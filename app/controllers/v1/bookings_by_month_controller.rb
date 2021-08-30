module V1
    class BookingsByMonthController < ActionController::API
      def show
        bookings_by_month = Booking.
          where(created_at: Date.current.all_year).
          group_by{ |booking| booking.created_at.month }.
          transform_values do |bookings|
            bookings.count do |booking|
              (booking.ends_on - booking.starts_on).to_i
            end
        end
  
        result = (1..12).map do |month|
          {
            'month' => Date.new(Date.current.year, month).strftime("%Y-%m"),
            'value' => bookings_by_month[month] || 0
          }
        end
  
        render json: result
      end
    end
  end