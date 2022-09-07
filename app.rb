require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/listings_repository'
require_relative 'lib/user_repository'
require_relative 'lib/database_connection'
DatabaseConnection.connect('makersbnb')

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

  get "/new_user" do
    erb(:new_user)
  end

  post "/new_user" do
    u_repo = UserRepository.new
    new_user = User.new
    new_user.email = params[:email]
    new_user.password = params[:password]

    repo = ListingsRepository.new 
    @listings = repo.all

    if u_repo.create(new_user) == 'created'
    #   return erb(:view_spaces)
    # else
      return erb(:view_spaces)
    else
      return 'error'
    end


  end

  get "/bnb1" do
    erb(:bnb1)
  end
end

