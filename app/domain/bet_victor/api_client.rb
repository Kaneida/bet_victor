class BetVictor::ApiClient
  API_ENDPOINT = URI.parse("http://www.betvictor.com/live/en/live/list.json")

  def sports
    begin
      list.fetch("sports").inject([]) do |sports, s|
        sports << Sport.new(:id => s["id"], :title => s["title"])
      end
    rescue => e
      Rails.logger.info "API fetching sports failed: #{e.message}"

      []
    end
  end

  def sport(id)
    sport = sports.find {|s| s.id == id}
    raise BetVictor::RecordNotFound.new if sport.nil?

    sport
  end

  def events(sport_id)
    begin
      sport = list.fetch("sports").find {|s| s["id"] == sport_id}
      raise BetVictor::RecordNotFound.new if sport.nil?

      sport["events"].inject([]) do |events, e|
        events << Event.new(
          :id => e["id"],
          :sport_id => sport_id,
          :title => e["title"],
          :pos => e["pos"]
        )
      end.sort {|a, b| a.pos <=> b.pos}
    rescue => e
      Rails.logger.info "API fetching events failed: #{e.message}"

      []
    end
  end

  def event(sport_id, id)
    event = events(sport_id).find {|e| e.id == id}
    raise BetVictor::RecordNotFound.new if event.nil?

    event
  end

  def outcomes(sport_id, event_id)
    begin
      sport = list.fetch("sports").find {|s| s["id"] == sport_id}
      raise BetVictor::RecordNotFound.new if sport.nil?

      event = sport.fetch("events").find {|e| e["id"] == event_id}
      raise BetVictor::RecordNotFound.new if event.nil?

      event["outcomes"].inject([]) do |outcomes, o|
        outcomes << Outcome.new(
          :id => o["id"],
          :sport_id => sport_id,
          :event_id => event_id,
          :description => o["description"]
        )
      end
    rescue => e
      Rails.logger.info "API fetching outcomes failed: #{e.message}"

      []
    end
  end

  protected
  def list
    @list ||= JSON.parse(Net::HTTP.get_response(API_ENDPOINT).body) rescue {}
  end
end
