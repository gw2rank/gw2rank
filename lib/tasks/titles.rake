namespace :titles do
  task import: :environment do
    connection = Faraday.new(
      url: "https://api.guildwars2.com",
    ) 
    response = connection.get("/v2/titles", ids: "all")
    titles = JSON.parse(response.body)
    titles.each do |title|
      t = Title.where(gw_id: title["id"]).first_or_initialize
      t.achievement_gw_id = title["achievement"]
      t.name = title["name"]
      t.json = title
      t.save
    end
  end
end
