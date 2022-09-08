require_relative 'listings'

class ListingsRepository
  def all
    listings = []

    # Send the SQL query and get the result set.
    sql = 'SELECT * FROM listings;'
    result_set = DatabaseConnection.exec_params(sql, [])
      return listing_object(result_set)
    # The result set is an array of hashes.
    # Loop through it to create a model
    # object for each listing hash.
  end

  def create(listing)
    sql = 'INSERT INTO listings (name, description, price, date_to, date_from, user_id) VALUES ($1, $2, $3, $4, $5, $
6);'
    result_set = DatabaseConnection.exec_params(
      sql, 
      [listing.name, 
      listing.description, 
      listing.price, 
      listing.date_to, 
      listing.date_from, 
      listing.user_id ]
    )

    return listing
  end

  private

  def listing_object(result)
    listings = []
    result.each do |listing|
      # Create a new model object
      # with the listing data.
      property = Listings.new
      property.id = listing['id'].to_i
      property.name = listing['name']
      property.description = listing['description']
      property.date_from = listing['date_from']
      property.date_to = listing['date_to']
      property.price = listing['price'].to_i
      property.user_id = listing['user_id'].to_i
      listings << property
    end

    return listings
  end
end