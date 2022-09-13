class Player < ApplicationRecord
  encrypts :api_key

  scope :top_3, -> { where("best_rank IN (?)", [1, 2, 3]) }
  scope :with_titles, -> { where.not(titles: nil) }

  extend FriendlyId
  friendly_id :igname, use: :slugged
end
