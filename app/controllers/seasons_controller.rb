class SeasonsController < ApplicationController
  def index
    @seasons = Season.published_seasons.order(start: :desc)
  end

  def show
    season = Season.find(params[:id])
    @na_ladder = season.ladders.find_by(region: 'na')
    @na_players = JSON.parse(@na_ladder.json)
    @eu_ladder = season.ladders.find_by(region: 'eu')
    @eu_players = JSON.parse(@eu_ladder.json)
  end
end
