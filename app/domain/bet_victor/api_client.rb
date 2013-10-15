class BetVictor::ApiClient
  API_ENDPOINT = URI.parse("http://www.betvictor.com/live/en/live/list.json")

  def sports
    list.fetch("sports") rescue []
  end

  protected
  def list
    JSON.parse(Net::HTTP.get_response(API_ENDPOINT).body) rescue {}
  end
end
