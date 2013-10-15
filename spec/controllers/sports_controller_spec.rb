require 'spec_helper'

describe SportsController do
  let(:football) { double(:sport, "id" => 1, "title" => "Football") }
  let(:baseball) { double(:sport, "id" => 2, "title" => "Baseball") }

  describe "GET /index" do
    it "should fetch the sports" do
      Sport.stub(:all) { [football, baseball] }

      get :index

      assigns[:sports].should have(2).items
    end
  end

  describe "GET /show" do
    context "not found" do
      it "shows 404 page" do
        Sport.should_receive(:find).and_raise BetVictor::RecordNotFound

        get :show, :id => 1

        response.status.should == 404
      end
    end

    context "find the sport to be shown" do
      it "shows the detail of the sport" do
        Sport.stub(:find) { football }

        get :show, :id => 1

        response.status.should == 200
      end
    end
  end
end
