class SportsController < ApplicationController
  def index
    @sports = api_client.sports
  end

  def show
    @sport = api_client.sport(params[:id].to_i)
  end
end
