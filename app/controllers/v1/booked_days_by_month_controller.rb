module v1
    class BookedDaysByMonthController < ActionController::API
      def index
        # returns a list of all months up till (and including) current one in current year...
          bookings = Booking.all.select do |booking|
            booking_create = (booking.created_at)




          booking_dates = (booking.starts_on..booking.ends_on)
          query_dates = (Date.parse(params.fetch(:start_date))..Date.parse(params.fetch(:end_date)))
          booking_dates.overlaps?(query_dates)
        end
  
        # aggregate items for those bookings
        booked_items = bookings.flat_map do |booking|
          booking.items
        end.uniq
  
        # return all items but those aggregated
        booking_in_month = Bookings.where.not  
  
        render json: booking_in_month.as_json(only: [:created_at, :starts_on, :ends_on])
      end
    end
  end