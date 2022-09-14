namespace :players do
  namespace :titles do
    task update: :environment do
      connection = Faraday.new(
        url: "https://api.guildwars2.com",
      )
      Player.where.not(api_key: nil).each do |player|
        response = connection.get("/v2/account/titles", {}, { Authorization: "Bearer #{player.api_key}" })
        player_titles = JSON.parse(response.body)
        player.update(titles: player_titles)
      end
    end
  end

  namespace :achievements do
    task update: :environment do
      connection = Faraday.new(
        url: "https://api.guildwars2.com",
      )
      Player.where.not(api_key: nil).each do |player|
        response = connection.get("/v2/account/achievements", {}, { Authorization: "Bearer #{player.api_key}" })
        player_achievements = JSON.parse(response.body)
        next if response.body["text"].present?
        player_achievements.each do |achievement|
          a = Achievement.find_by(gw_id: achievement["id"])
          pa = player.player_achievements.where(achievement: a).first_or_initialize
          pa.bits = achievement["bits"]
          pa.current = achievement["current"]
          pa.max = achievement["max"]
          pa.done = achievement["done"]
          pa.repeated = achievement["repeated"]
          pa.unlocked = achievement["unlocked"]
          pa.save
        end
      end
    end
  end
end
