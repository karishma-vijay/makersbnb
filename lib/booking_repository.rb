require_relative 'booking'

class BookingRepository

    def find(id)

        sql = 'SELECT * FROM bookings WHERE id = $1'
        result = DatabaseConnection.exec_params(sql, [id])

        booking = Booking.new
        booking.id = result[0]['id'].to_i
        booking.approval = result[0]['approval']
        booking.listing_id = result[0]['listing_id'].to_i
        booking.user_id = result[0]['user_id'].to_i
        booking.check_in = result[0]['check_in']
        booking.check_out = result[0]['check_out']

        return booking
    end

    def approve(id)
        sql = 'UPDATE bookings SET approval = true WHERE id = $1'
        result = DatabaseConnection.exec_params(sql, [id])
    end

    def not_approved_by_listing_id(listing_id)

        arr = []
        sql = "SELECT * FROM bookings WHERE listing_id = $1 AND approval = false"
        result = DatabaseConnection.exec_params(sql, [listing_id])

        result.each do |b|
            booking = Booking.new
            booking.id = b['id'].to_i
            booking.approval = b['approval']
            booking.listing_id = b['listing_id'].to_i
            booking.user_id = b['user_id'].to_i
            booking.check_in = b['check_in']
            booking.check_out = b['check_out']

            arr << booking
        end

        return arr
    end

    def approved_by_listing(listing_id)

        arr = []
        sql = "SELECT * FROM bookings WHERE listing_id = $1 AND approval = true"
        result = DatabaseConnection.exec_params(sql, [listing_id])

        result.each do |b|
            booking = Booking.new
            booking.id = b['id'].to_i
            booking.approval = b['approval']
            booking.listing_id = b['listing_id'].to_i
            booking.user_id = b['user_id'].to_i
            booking.check_in = b['check_in']
            booking.check_out = b['check_out']

            arr << booking

        end
        return arr 

    end
end
