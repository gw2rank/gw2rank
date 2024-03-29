class PlayersController < ApplicationController
  def index
    if params[:q].present?
      @q = params[:q].html_safe
      @pagy, @players = pagy(Player.with_titles.whose_igname_starts_with(@q).order(player_achievements_count: :desc))
      @top_3_players = Player.top_3.whose_igname_starts_with(@q)
    else
      @q = nil
      @pagy, @players = pagy(Player.with_titles.order(player_achievements_count: :desc), items: 10)
      @top_3_players = Player.top_3
    end
  end

  def show
    @player = Player.friendly.find(params[:id])
    @titles = Title.where("gw_id IN (?)", @player.titles) if @player.titles.present?
    @achievement_groups = AchievementGroup.all.includes(:achievement_categories)
  end

  def new
    if current_user
      @player = current_user.players.new
    else
      @player = Player.new
    end
  end

  def create
    connection = Faraday.new(
      url: "https://api.guildwars2.com",
    )
    render :new && return unless player_params[:api_key].length.eql?(72)
    response = connection.get("/v2/account", {}, { Authorization: "Bearer #{player_params[:api_key]}" })
    render :new && return if response.body["text"].present?
    account = JSON.parse(response.body)

    @player = Player.where(igname: account["name"]).first_or_initialize
    @player.api_key = player_params[:api_key]
    @player.user = current_user if current_user

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
