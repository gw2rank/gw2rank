class PlayersController < ApplicationController
  def index
    @top_3_players = Player.top_3
    @players_with_titles = Player.with_titles
  end

  def show
    @player = Player.friendly.find(params[:id])
    @titles = Title.where("gw_id IN (?)", @player.titles) if @player.titles.present?
  end
end
