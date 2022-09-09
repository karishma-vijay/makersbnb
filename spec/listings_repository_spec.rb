require "spec_helper"
require "rack/test"
require_relative "../app"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET to /view-spaces" do 
    it "views the page title" do
      response = get("/view_spaces")

      expect(response.status).to eq(200)
      expect(response.body).to include("Your available spaces")
    end
  end

  context "GET /view_spaces/new" do
    it 'returns a form page to add a new listing' do
      response = get('/view_spaces/new')
  
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Add new listing</h1>')
      expect(response.body).to include('<form action="/view_spaces" method="POST" >')
      expect(response.body).to include('<input type="DATE" name="date_from" />')
      # We can assert more things, like having
      # the right HTML form inputs, etc.
    end
  end

end