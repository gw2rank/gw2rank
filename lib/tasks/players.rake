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
end
