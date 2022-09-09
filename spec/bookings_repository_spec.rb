require_relative '../app'
require 'spec_helper'
require 'rack/test'
require 'datecheck'
require 'date'
require 'listing'
require 'booking'

def reset_listings_table
    seed_sql = File.read('spec/seeds_listings.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb' })
    connection.exec(seed_sql)
end

RSpec.describe Datecheck do
    #before(:each) do 
    #    reset_listings_table
    #end

    it "checks the dates are an array" do
        listing = Listing.new
        date = Datecheck.new
        listing.name = "nice place"
        listing.description = "no murders happened here"
        listing.date_from = Date.parse('1-8-2022')
        listing.date_to = Date.parse('20-8-2022')
        listing.price = "200"
        date.create(listing)

        expect(date.totaldays).to eq(20)
    end

    it "checks for property availability overlap" do
        listing = Listing.new
        date = Datecheck.new
        expect(date.overlapcheck("2022-08-05")).to eq(true)
        expect(date.overlapcheck("2021-08-05")).to eq(false)
        expect(date.overlapcheck("2022-09-05")).to eq(false)
        expect(date.overlapcheck("2022-08-20")).to eq(true)
    end

    it "checks for prebooked overlap" do
        booking = Booking.new
        date = Datecheck.new

        expect(date.prebookedoverlap_check("2022-09-18")).to eq(true)
        expect(date.prebookedoverlap_check("2021-08-05")).to eq(false)
        expect(date.prebookedoverlap_check("2022-09-05")).to eq(false)
    end

    it "checks for property availability overlap across a couple dates" do
        listing = Listing.new
        date = Datecheck.new
        expect(date.overlapcheck_multi("2022-08-01, 2022-08-07")).to eq("there is already a booking from 2022-08-01 to 2022-08-07, please amend booking dates")
        expect(date.overlapcheck_multi("2022-08-01")).to eq("already booked for them days")

    end

    it "checks puts everything together and checks it all" do
        
    end
end