require File.expand_path("../../../app/domain/sport", __FILE__)

describe Sport do
  let(:api_client) { double(:api_client) }
  let(:football) { {"id" => 1, "title" => "Football"} }
  let(:baseball) { {"id" => 2, "title" => "Baseball"} }

  before do
    Sport.api_client = api_client
  end

  describe ".all" do
    it "finds all the events" do
      api_client.stub(:sports) { [football, baseball] }

      Sport.all.should have(2).items
    end
  end

  describe ".find" do
    context "not found" do
      it "raises exception for empty set" do
        api_client.stub(:sports) {[]}

        lambda do
          Sport.find(1)
        end.should raise_error(BetVictor::RecordNotFound)
      end

      it "raises exception for non matches" do
        api_client.stub(:sports) {[basketball]}

        lambda do
          Sport.find(1)
        end.should raise_error(BetVictor::RecordNotFound)
      end
    end

    context "find the specific sport" do
      it "finds the specific sport" do
        api_client.stub(:sports) {[football]}

        sport = Sport.find(1)
        sport.title.should == "Football"
      end
    end
  end

  describe "#event" do
    let (:sport) {Sport.new}

    context "not found" do
      it "raises exception for empty set" do
        sport.events = []

        lambda do
          sport.event(1)
        end.should raise_error(BetVictor::RecordNotFound)
      end

      it "raises exception for non matches" do
        sport.events = [double(:id => 2, :title => "Thailand vs. Iran")]

        lambda do
          sport.event(1)
        end.should raise_error(BetVictor::RecordNotFound)
      end
    end

    context "find the specific event" do
      it "finds the specific event" do
        sport.events = [double(:id => 1, :title => "Thailand vs. Iran")]

        event = sport.event(1)
        event.title.should == "Thailand vs. Iran"
      end
    end
  end
end
