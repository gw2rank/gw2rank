namespace :achievements do
  task import: :environment do
    connection = Faraday.new(
      url: "https://api.guildwars2.com",
    )
    I18n.available_locales.each do |locale|
      achievements_response = connection.get("/v2/achievements")
      return if achievements_response.body["text"].present?
      achievement_ids = JSON.parse(achievements_response.body)
      achievement_ids.each do |achievement_id|
        a = Achievement.where(gw_id: achievement_id).first_or_initialize
        next if a.name_fr.present?
        achievement_response = connection.get("/v2/achievements?lang=#{locale.to_s}", id: achievement_id)
        return if achievement_response.body["text"].present?
        achievement = JSON.parse(achievement_response.body)
        next if response.body["text"].present?
        a.gw_id = achievement["id"]
        a.icon = achievement["icon"]
        case locale
        when :en
          a.name_en = achievement["name"]
          a.description_en = achievement["description"]
          a.requirement_en = achievement["requirement"]
          a.locked_text_en = achievement["locked_text"]
        when :fr
          a.name_fr = achievement["name"]
          a.description_fr = achievement["description"]
          a.requirement_fr = achievement["requirement"]
          a.locked_text_fr = achievement["locked_text"]
        end
        a.gw_type = achievement["type"]
        a.flags = achievement["flags"]
        a.tiers = achievement["tiers"]
        a.prerequisites = achievement["prerequisites"]
        a.rewards = achievement["rewards"]
        a.bits = achievement["bits"]
        a.point_cap = achievement["point_cap"]
        a.save
      end
    end
  end
end
