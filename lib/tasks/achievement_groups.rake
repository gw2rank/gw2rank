namespace :achievement_groups do
  task import: :environment do
    connection = Faraday.new(
      url: "https://api.guildwars2.com",
    )
    I18n.available_locales.each do |locale|
      achievement_groups_response = connection.get("/v2/achievements/groups?ids=all&lang=#{locale.to_s}")
      achievement_groups = JSON.parse(achievement_groups_response.body)
      achievement_groups.each do |achievement_group|
        ag = AchievementGroup.where(gw_id: achievement_group["id"]).first_or_initialize
        ag.categories_array = achievement_group["categories"]
        ag.order = achievement_group["order"]
        case locale
        when :en
          ag.name_en = achievement_group["name"]
          ag.description_en = achievement_group["description"]
        when :fr
          ag.name_fr = achievement_group["name"]
          ag.description_fr = achievement_group["description"]
        end
        ag.save
      end
    end
  end

  task link_to_achievement_categories: :environment do
    AchievementGroup.all.each do |achievement_group|
      AchievementCategory.where("gw_id IN (?)", achievement_group.categories_array).update(achievement_group: achievement_group)
    end
  end
end
