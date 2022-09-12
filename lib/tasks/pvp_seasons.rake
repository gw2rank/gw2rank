namespace :pvp_seasons do
  task update: :environment do
    REGIONS = ['eu', 'na']

    seasons_url = 'https://api.guildwars2.com/v2/pvp/seasons'
    gw_pvp_seasons_response = RestClient.get seasons_url
    JSON.parse(gw_pvp_seasons_response.body).each_with_index do |pvp_season_id, index|
      season = Season.where(gw_id: pvp_season_id).first_or_create
      season_url = "#{seasons_url}/#{pvp_season_id}"
      gw_pvp_season_response = RestClient.get season_url
      gw_pvp_season_json = gw_pvp_season_response.body
      gw_pvp_season = JSON.parse(gw_pvp_season_json)
      season.update(
        name: gw_pvp_season['name'],
        start: gw_pvp_season['start'],
        end: gw_pvp_season['end'],
        active: gw_pvp_season['active'],
        json: gw_pvp_season_json
      )
      gw_ladder_path = 'ladder'
      if index < 4
        gw_ladder_path = 'legendary'
        season.update(published: false)
      end
      REGIONS.each do |region|
        ladder_url = "#{season_url}/leaderboards/#{gw_ladder_path}/#{region}"
        ladder = Ladder.where(season: season, region: region).first_or_create
        gw_pvp_ladder_response = RestClient.get ladder_url
        gw_pvp_ladder_json = gw_pvp_ladder_response.body
        gw_pvp_ladder = JSON.parse(gw_pvp_ladder_json)
        ladder.update(json: gw_pvp_ladder_json)
        gw_pvp_ladder.each do |gw_player|
          player = Player.where(igname: gw_player['name']).first_or_create
          if gw_player['scores'][0]['value'] < player.best_rating
            player.update(
              best_rating: gw_player['scores'][0]['value'],
              best_rating_season_id: season.id
            )
          end
        end
      end
    end
  end
end
