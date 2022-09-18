class Achievement < ApplicationRecord
  belongs_to :achievement_category, optional: true

  scope :with_icons, -> { where.not(icon: nil) }

  translates :name, :description, :requirement, :locked_text

  def icon_url
    icon.present? ? icon : achievement_category&.icon
  end
end
