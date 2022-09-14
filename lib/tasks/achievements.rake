namespace :achievements do
  task import: :environment do
    connection = Faraday.new(
      url: "https://api.guildwars2.com",
    )
    Player.where.not(api_key: nil).each do |player|
      achievements_response = connection.get("/v2/achievements")
      achievement_ids = JSON.parse(achievements_response.body)
      achievement_ids.each do |achievement_id|
        achievement_response = connection.get("/v2/achievements", id: achievement_id)
        achievement = JSON.parse(achievement_response.body)
        a = Achievement.where(gw_id: achievement["id"]).first_or_initialize
        a.gw_id = achievement["id"]
        a.icon = achievement["icon"]
        a.name = achievement["name"]
        a.description = achievement["description"]
        a.locked_text = achievement["locked_text"]
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
