require 'spec_helper'

describe EventsController do
  let(:sport) { double(:sport, "id" => 1, "title" => "Football") }
  let(:b_vs_r) { double(:event, "id" => 1, "title" => "Barca vs. R.M.") }
  let(:m_vs_a) { double(:event, "id" => 2, "title" => "Man U. vs. Arsenal") }

  before do
    Sport.stub(:find) { sport }
  end

  describe "GET /index" do
    it "should fetch the events" do
      sport.stub(:events) { [b_vs_r, m_vs_a] }

      get :index, :sport_id => 1

      assigns[:events].should have(2).items
    end
  end

  describe "GET /show" do
    context "not found" do
      it "shows 404 page" do
        sport.should_receive(:event).and_raise BetVictor::RecordNotFound

        get :show, :sport_id => 1, :id => 1

        response.status.should == 404
      end
    end

    context "find the event to be shown" do
      it "shows the detail of the event" do
        sport.stub(:event) { m_vs_a }

        get :show, :sport_id => 1, :id => 1

        response.status.should == 200
      end
    end
  end
end
