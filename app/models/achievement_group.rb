class AchievementGroup < ApplicationRecord
  has_many :achievement_categories, dependent: :nullify
  has_many :achievements, through: :achievement_categories

  translates :name, :description
end
