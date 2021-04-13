class Season < ApplicationRecord
  has_many :ladders

  scope :current, -> { where(active: true).order(start: :desc).first }
  scope :published_seasons, -> { where(published: true) }
end
