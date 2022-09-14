class Achievement < ApplicationRecord
  scope :with_icons, -> { where.not(icon: nil) }

  def wiki_go_url
    "https://wiki.guildwars2.com/index.php?title=Special:Search&search=#{name}&fulltext=Search"
  end
end
