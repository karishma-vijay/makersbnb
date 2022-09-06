require "spec_helper"
require "rack/test"
require_relative "../../app"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "when GET to /view-spaces" do 
    it "views the page title" do
      response = get("/view-spaces")

      expect(response.status).to eq(200)
      expect(response.body).to include("Your available spaces")
    end
  end
end
