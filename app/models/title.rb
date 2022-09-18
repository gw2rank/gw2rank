class Title < ApplicationRecord
  belongs_to :achievement, optional: true

  translates :name, :json

  def icon_url
    achievement.icon_url if achievement.present?
  end
end
