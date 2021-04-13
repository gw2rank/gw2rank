class LeaderboardsController < ApplicationController
  def index
    redirect_to seasons_path
  end
end
