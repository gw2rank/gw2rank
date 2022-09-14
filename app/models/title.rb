class Title < ApplicationRecord
  def wiki_go_url
    "https://wiki.guildwars2.com/index.php?title=Special:Search&search=#{name}&fulltext=Search"
  end
end
