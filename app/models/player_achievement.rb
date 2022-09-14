class PlayerAchievement < ApplicationRecord
  belongs_to :player
  belongs_to :achievement

  def progress
    (current * 100) / max
  end
end
