namespace :achievement_categories do
  task import: :environment do
    connection = Faraday.new(
      url: "https://api.guildwars2.com",
    )
    I18n.available_locales.each do |locale|
      achievement_categories_response = connection.get("/v2/achievements/categories?ids=all&lang=#{locale.to_s}")
      achievement_categories = JSON.parse(achievement_categories_response.body)
      achievement_categories.each do |achievement_category|
        ac = AchievementCategory.where(gw_id: achievement_category["id"]).first_or_initialize
        next unless ac.new_record?
        ac.gw_id = achievement_category["id"]
        ac.icon = achievement_category["icon"]
        ac.order = achievement_category["order"]
        ac.achievements_array = achievement_category["achievements"]
        case locale
        when :en
          ac.name_en = achievement_category["name"]
          ac.description_en = achievement_category["description"]
        when :fr
          ac.name_fr = achievement_category["name"]
          ac.description_fr = achievement_category["description"]
        end
        ac.save
      end
    end
  end

  task link_to_achievements: :environment do
    AchievementCategory.all.each do |achievement_category|
      Achievement.where("gw_id IN (?)", achievement_category.achievements_array).update(achievement_category: achievement_category)
    end
  end
end
