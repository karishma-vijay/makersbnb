require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/listings_repository'
require_relative 'lib/database_connection'
DatabaseConnection.connect('makersbnb_test')

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get "/view_spaces" do
    repo = ListingsRepository.new 
    @listings = repo.all
    erb(:view_spaces)
    # binding.irb
  end
end

