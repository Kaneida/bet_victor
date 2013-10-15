require File.expand_path("../../../../app/domain/bet_victor/api_client", __FILE__)
require 'webmock/rspec'

describe BetVictor::ApiClient do
  describe "#sports" do
    let (:api_client) {BetVictor::ApiClient.new}

    before do
      stub_request(
        :get,
        "http://www.betvictor.com/live/en/live/list.json"
      ).to_return(
        :body => File.read("spec/fixtures/list.json")
      )
    end

    it "lists all the sports" do
      sports = api_client.sports

      sports.should have(17).items
    end
  end
end
