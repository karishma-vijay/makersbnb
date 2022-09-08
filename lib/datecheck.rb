require 'date'
require 'listing'
require 'booking'

date_in = Date.parse('1-8-2022')
date_out = Date.parse('20-8-2022')

#puts (date_in..date_out).to_a

class Datecheck
    def totaldays
        # Send the SQL query and get the result set.
        sql = 'SELECT date_from, date_to FROM listings;'
        listing = DatabaseConnection.exec_params(sql, [])
        
        
        date_from = listing[0]['date_from']
        date_to = listing[0]['date_to']
        date_a = (date_from..date_to).to_a
        return date_a.length
    end
#ignore this, it was just first version of the code
    def overlapcheck(date)
        sql = 'SELECT date_from, date_to FROM listings;'
        listing = DatabaseConnection.exec_params(sql, [])
        
        dates = Date.parse(date)
        date_from = listing[0]['date_from']
        date_to = listing[0]['date_to']
        date_a = (date_from..date_to).to_a

        

        return date_a.include?(date)

    end
    #ignore this, its just a dummy run one
    def prebookedoverlap_check(date)
        sql1 = 'SELECT check_in, check_out FROM bookings;'
        booking = DatabaseConnection.exec_params(sql1, [])

        date_from = booking[0]['check_in']
        date_to = booking[0]['check_out']
        date_a = (date_from..date_to).to_a

        return date_a.include?(date)

    end
    #this method is the main method
    #all of the listings are pulled into this method to check if their is any overlaps
    #if someone could the add a WHERE function in sql to pick which listing it is looking for that would be great
    #the dates get put in the argument as seperate string, look at tests to see the input
    #creates an array of those 2 dates inputted into the arugment, again look at test for ref, 
    #then creates and array of all of the dates inbetween
    #then will spit out if they can book, that could be changed like we did with the post user stuff
    #it will then say what dates over lap, so for example "the dates 20/02/2022 to the 21/02/2022, amend booking"
    #if there is no over laps it returns that its fine to book
    def overlapcheck_multi(dates)
        outcome_a = []
        sql = 'SELECT date_from, date_to FROM listings;'
        listing = DatabaseConnection.exec_params(sql, [])
        
        bookeddates_a = dates.split(', ')
        booked_from = bookeddates_a[0]
        booked_to = bookeddates_a[-1]
        bookeddates_range_a = (booked_from..booked_to).to_a
        
        date_from = listing[0]['date_from']
        date_to = listing[0]['date_to']
        date_a = (date_from..date_to).to_a

        overlap_dates = []

        date_a.each do |x|
            record = bookeddates_range_a.include?(x)
            if bookeddates_range_a.each.include?(x)
                overlap_dates << x
            end

            outcome_a << record
        end
        
        if outcome_a.include?(true) && overlap_dates.length < 2
            return "there is already a booking on the #{overlap_dates[0]}, please amend booking"
        elsif outcome_a.include?(true) && overlap_dates.length > 1
            return "there is already a booking from #{overlap_dates[0]} to #{overlap_dates[-1]}, please amend booking dates"
        else
            return "available on that date"
        end

    end

    #this is just to create the listing, can be take out or just ignored because we have mohammeds
    def create(listing)
        sql = 'INSERT INTO listings (name, description, date_from, date_to, price) VALUES ($1, $2, $3, $4, $5);'
        result_set = DatabaseConnection.exec_params(sql, [listing.name, listing.description, listing.date_from, listing.date_to, listing.price])
    
        return listing
      end
end