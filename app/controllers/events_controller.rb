class EventsController < ApplicationController
  before_filter :load_sport

  def index
    @events = @sport.events
  end

  def show
    @event = @sport.event(params[:id].to_i)
  end

  protected
  def load_sport
    @sport = Sport.find(params[:sport_id].to_i)
  end
end
