class PlayersController < ApplicationController
  def index
    @top_3_players = Player.top_3
    @players_with_titles = Player.with_titles
  end

  def show
    @player = Player.friendly.find(params[:id])
    @titles = Title.where("gw_id IN (?)", @player.titles) if @player.titles.present?
  end

  def new
    @player = current_user.players.new
  end

  def create
    connection = Faraday.new(
      url: "https://api.guildwars2.com",
    )
    render :new && return unless player_params[:api_key].length.eql?(72)
    response = connection.get("/v2/account", {}, { Authorization: "Bearer #{player_params[:api_key]}" })
    render :new && return if response.body["text"].present?
    account = JSON.parse(response.body)

    @player = Player.where(igname: account["name"].capitalize).first_or_initialize
    @player.user_id = current_user.id

    if @player.save
      @player.update_titles
      @player.update_achievements
      redirect_to player_path(@player)
    else
      render :new
    end
  end

  private

  def player_params
    params.require(:player).permit(:api_key)
  end
end
