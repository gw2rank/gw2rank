class Player < ApplicationRecord
  belongs_to :user, optional: true
  has_many :player_achievements
  has_many :achievements, through: :player_achievements

  encrypts :api_key

  scope :top_3, -> { where("best_rank IN (?)", [1, 2, 3]) }
  scope :with_titles, -> { where.not(titles: nil) }

  extend FriendlyId
  friendly_id :igname, use: :slugged

  def done_achievements
    achievements.where("player_achievements.done = ?", true)
  end

  def current_player_achievements
    player_achievements.where("player_achievements.done = ?", false)
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
