class Sport
  attr_accessor :id, :title, :events

  class << self
    attr_accessor :api_client

    protected
    def api_client
      @api_client ||= BetVictor::ApiClient.new
    end
  end

  def initialize(args={})
    @id = args["id"]
    @title = args["title"]

    @events = args["events"].to_a.inject([]) do |events, e|
      events << Event.new(e)
    end
  end

  def self.all
    api_client.sports.inject([]) do |sports, s|
      sports << Sport.new(s)
    end
  end

  def self.find(id)
    sport = all.find{|e| e.id==id} rescue nil

    raise BetVictor::RecordNotFound.new if sport.nil?

    sport
  end

  def events
    @events.sort { |a, b| a.pos <=> b.pos }
  end

  def event(id)
    result = @events.find{|e| e.id==id} rescue nil

    raise BetVictor::RecordNotFound.new if result.nil?

    result
  end
end
