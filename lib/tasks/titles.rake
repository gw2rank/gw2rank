namespace :titles do
  task import: :environment do
    connection = Faraday.new(
      url: "https://api.guildwars2.com",
    ) 
    I18n.available_locales.each do |locale|
      response = connection.get("/v2/titles?lang=#{locale.to_s}", ids: "all")
      titles = JSON.parse(response.body)
      titles.each do |title|
        t = Title.where(gw_id: title["id"]).first_or_initialize
        t.achievement_gw_id = title["achievement"]
        case locale
        when :en
          t.name_en = title["name"]
          t.json_en = title
        when :fr
          t.name_fr = title["name"]
          t.json_fr = title
        end
        t.save
      end
    end
  end
end
