class Player < ApplicationRecord
  belongs_to :user, optional: true
  has_many :player_achievements
  has_many :achievements, through: :player_achievements

  encrypts :api_key

  scope :top_3, -> { where("best_rank IN (?)", [1, 2, 3]) }
  scope :with_titles, -> { where.not(titles: nil) }
  scope :with_api_key, -> { where.not(api_key: nil) }

  include PgSearch::Model
  pg_search_scope :whose_igname_starts_with,
    against: :igname,
    using: {
      tsearch: { prefix: true }
    }

  extend FriendlyId
  friendly_id :igname, use: :slugged

  def achievements_points
    achievements
      .pluck("achievements.tiers").flatten.map { |t| t["points"] }.sum
  end

  def achievements_points_by_group_id(group_id)
    achievement_group = AchievementGroup.find(group_id)
    category_ids = achievement_group.achievement_categories.pluck(:id)
    achievements.where("achievements.achievement_category_id IN (?)", category_ids)
      .pluck("achievements.tiers").flatten.map { |t| t["points"] }.sum
  end

  def achievements_points_by_category_id(category_id)
    achievements_by_category_id(category_id)
      .pluck("achievements.tiers").flatten.map { |t| t["points"] }.sum
  end

  def achievements_by_category_id(category_id)
    achievements.where("achievements.achievement_category_id = ?", category_id)
  end

  def done_achievements
    achievements.where("player_achievements.done = ?", true)
  end

  def done_achievements_count
    done_achievements.count
  end

  def done_achievements_by_category_id(category_id)
    done_achievements.where("achievements.achievement_category_id = ?", category_id)
  end

  def current_player_achievements
    player_achievements.where("player_achievements.done = ?", false)
  end

  def fix_account_name
    connection = Faraday.new(
      url: "https://api.guildwars2.com",
    )
    response = connection.get("/v2/account", {}, { Authorization: "Bearer #{self.api_key}" })
    account = JSON.parse(response.body)
    return if response.body["text"].present?
    self.update(igname: account["name"]) unless self.igname.eql?(account["name"])
  end

  def titles_count
    titles.length
  end

  def update_achievements
    connection = Faraday.new(
      url: "https://api.guildwars2.com",
    )
    response = connection.get("/v2/account/achievements", {}, { Authorization: "Bearer #{self.api_key}" })
    player_achievements = JSON.parse(response.body)
    return if response.body["text"].present?
    player_achievements.each do |achievement|
      a = Achievement.find_by(gw_id: achievement["id"])
      pa = self.player_achievements.where(achievement: a).first_or_initialize
      pa.bits = achievement["bits"]
      pa.current = achievement["current"]
      pa.max = achievement["max"]
      pa.done = achievement["done"]
      pa.repeated = achievement["repeated"]
      pa.unlocked = achievement["unlocked"]
      pa.save
    end
  end

  def update_titles
    connection = Faraday.new(
      url: "https://api.guildwars2.com",
    )
    response = connection.get("/v2/account/titles", {}, { Authorization: "Bearer #{self.api_key}" })
    return if response.body["text"].present?
    player_titles = JSON.parse(response.body)
    self.update(titles: player_titles)
  end
end
