class PlayerAchievement < ApplicationRecord
  belongs_to :player, counter_cache: true
  belongs_to :achievement

  def progress
    (current * 100) / max
  end
end
