class Player < ApplicationRecord
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

  def undone_achievements
    achievements.where("player_achievements.done = ?", false)
  end
end
