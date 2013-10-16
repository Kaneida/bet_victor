class EventsController < ApplicationController
  before_filter :load_sport

  def index
    @events = api_client.events(@sport.id)
  end

  def show
    @event = api_client.event(@sport.id, params[:id].to_i)

    @outcomes = api_client.outcomes(@sport.id, @event.id)
  end

  protected
  def load_sport
    @sport = api_client.sport(params[:sport_id].to_i)
  end
end
