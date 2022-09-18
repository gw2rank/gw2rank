class AchievementCategory < ApplicationRecord
  belongs_to :achievement_group, optional: true
  has_many :achievements, dependent: :nullify

  translates :name, :description
end
