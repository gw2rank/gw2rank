class LeaderboardsController < ApplicationController
  def index
    response = RestClient.get ENV['LADDER_EU_URL']
    @eu_ladder = response.body
    response = RestClient.get ENV['LADDER_NA_URL']
    @na_ladder = response.body
  end
end
