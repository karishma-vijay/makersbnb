require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/listings_repository'
require_relative 'lib/user_repository'
require_relative 'lib/database_connection'
DatabaseConnection.connect

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

  get '/view_spaces/new' do
    return erb(:new_listing)
  end

  post '/view_spaces' do
    repo = ListingsRepository.new
    new_listing = Listings.new
    new_listing.name = params[:name]
    new_listing.description = params[:description]
    new_listing.price = params[:price]
    new_listing.date_from = params[:date_from]
    new_listing.date_to = params[:date_to]

    repo.create(new_listing)
  
    return 'Your new listing is now live!'
  end

  get "/new_user" do
    erb(:new_user)
  end

  post "/new_user" do
    user_repo = UserRepository.new
    new_user = User.new
    new_user.email = params[:email]
    new_user.password = params[:password]

    listings_repo = ListingsRepository.new 
    @listings = listings_repo.all

    if user_repo.create(new_user) == 'created'
      return erb(:view_spaces)
    else
      return user_repo.create(new_user)
    end
  end

  get "/log_in" do
    return erb(:log_in)
  end
  
  post "/log_in" do
    user_repo = UserRepository.new
    log_in = User.new
    log_in.email = params[:email]
    log_in.password = params[:password]

    @login_failed = nil

    listings_repo = ListingsRepository.new 
    @listings = listings_repo.all

    if user_repo.login(log_in) == 'Logged in successfully'
      @login_failed = nil
      return erb(:view_spaces)
    else
      @login_failed = true
      return erb(:log_in)
    end
  end
end

