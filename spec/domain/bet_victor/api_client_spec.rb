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

    describe "#sports" do
      it "lists all the sports" do
        sports = api_client.sports

        sports.should have(17).items
      end
    end

    describe "#sport" do
      context "find nothing" do
        it "raises exception" do
          lambda do
            api_client.sport(231231231231212313)
          end.should raise_error(BetVictor::RecordNotFound)
        end
      end

      it "returns the specific sport" do
        sport = api_client.sport(100)

        sport.title.should == "Football"
      end
    end

    describe "#events" do
      context "sport not found" do
        it "returns empty" do
          events = api_client.events(231231231231212313)

          events.should have(0).items
        end
      end

      it "lists all the events for the specific sport" do
        events = api_client.events(100)

        events.should have(11).items
      end
    end

    describe "#event" do
      context "sport not found" do
        it "raises exception" do
          lambda do
            api_client.event(231231231231212313, 167043210)
          end.should raise_error(BetVictor::RecordNotFound)
        end
      end

      context "event not found" do
        it "raises exception" do
          lambda do
            api_client.event(100, 231231231231212313)
          end.should raise_error(BetVictor::RecordNotFound)
        end
      end

      context "event present" do
        it "returns the specific event of the sport" do
          event = api_client.event(100, 167043210)

          event.title.should == "Jordan v Oman"
        end
      end
    end

    describe "#outcomes" do
      context "sport not found" do
        it "returns empty" do
          outcomes = api_client.outcomes(231231231231212313, 167043210)

          outcomes.should have(0).items
        end
      end

      context "event not found" do
        it "returns empty" do
          outcomes = api_client.outcomes(100, 231231231231212313)

          outcomes.should have(0).items
        end
      end

      it "lists all the outcomes for the specific sport and event" do
        outcomes = api_client.outcomes(100, 167043210)

        outcomes.should have(3).items
      end
    end
  end
end
