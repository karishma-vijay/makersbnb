require 'booking'
require 'booking_repository'

def reset_bookings_table
    seed_sql = File.read('spec/seeds_bookings.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb' })
    connection.exec(seed_sql)
end

describe BookingRepository do
    before(:each) do
        reset_bookings_table
    end

    it 'approves booking approval' do
        repo = BookingRepository.new

        booking = repo.find(3)

        expect(booking.approval).to eq 'f'

        repo.approve(3)

        booking = repo.find(3)

        expect(booking.approval).to eq 't'
    end

    it 'finds booking by id' do 
        repo = BookingRepository.new

        result = repo.find(1)

        expect(result.approval).to eq "t"
        expect(result.listing_id).to eq 1
        expect(result.user_id).to eq 1
        expect(result.check_in).to eq '2022-09-15'
        expect(result.check_out).to eq '2022-09-22'
    end
    
end
  