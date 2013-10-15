class EventsController < ApplicationController
  before_filter :load_sport

  def index

  end

  def show

  end

  protected
  def load_sport
    @sport = Sport.find(params[:sport_id])
  end
end
