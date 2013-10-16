require 'spec_helper'

describe SportsController do
  let(:api_client) {double(:api_client).as_null_object}

  let(:football) { double(:sport, "id" => 1, "title" => "Football") }
  let(:baseball) { double(:sport, "id" => 2, "title" => "Baseball") }

  before do
    controller.stub(:api_client) {api_client}
  end

  describe "GET /index" do
    it "should fetch the sports" do
      api_client.stub(:sports) { [football, baseball] }

      get :index

      assigns[:sports].should have(2).items
    end
  end

  describe "GET /show" do
    context "not found" do
      it "shows 404 page" do
        api_client.should_receive(:sport).and_raise BetVictor::RecordNotFound

        get :show, :id => 1

        response.status.should == 404
      end
    end

    context "find the sport to be shown" do
      it "shows the detail of the sport" do
        api_client.stub(:sport) { football }

        get :show, :id => 1

        response.status.should == 200
      end
    end
  end
end
