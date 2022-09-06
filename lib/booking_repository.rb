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
end
