class Achievement < ApplicationRecord
  scope :with_icons, -> { where.not(icon: nil) }

  translates :name, :description, :requirement, :locked_text
end
