class AchievementCategory < ApplicationRecord
  has_many :achievements, dependent: :nullify
end
