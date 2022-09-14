class Achievement < ApplicationRecord
  scope :with_icons, -> { where.not(icon: nil) }
end
