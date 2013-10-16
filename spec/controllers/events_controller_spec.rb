require 'spec_helper'

describe EventsController do
  let(:api_client) {double(:api_client).as_null_object}

  let(:b_vs_r) { double(:event, "id" => 1, "title" => "Barca vs. R.M.") }
  let(:m_vs_a) { double(:event, "id" => 2, "title" => "Man U. vs. Arsenal") }

  before do
    controller.stub(:api_client) {api_client}
  end

  describe "GET /index" do
    it "should fetch the events" do
      api_client.stub(:events) { [b_vs_r, m_vs_a] }

      get :index, :sport_id => 1

      assigns[:events].should have(2).items
    end
  end

  describe "GET /show" do
    context "not found" do
      it "shows 404 page" do
        api_client.should_receive(:event).and_raise BetVictor::RecordNotFound

        get :show, :sport_id => 1, :id => 1

        response.status.should == 404
      end
    end

    context "find the event to be shown" do
      it "shows the detail of the event" do
        api_client.stub(:event) { m_vs_a }

        get :show, :sport_id => 1, :id => 1

        response.status.should == 200
      end
    end
  end
end
