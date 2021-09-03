module V1
  class BookedDaysByMonthController < ActionController::API
    def show
      bookings_length_by_month = Booking.
        where(created_at: Date.current.all_year, by_admin: false).
        group_by{ |booking| booking.created_at.month }.
        transform_values do |bookings|
          bookings.sum do |booking|
            (booking.ends_on - booking.starts_on).to_i
          end
      end

      result = (1..Date.current.month).map do |month|
        {
          'category' => Date.new(Date.current.year, month).strftime("%Y-%m"),
          'value' => bookings_length_by_month[month] || 0
        }
      end

      render json: {
        data: {
          attributes: {
            name: 'Booked days by month',
            value: result
          }
        }
      }
    end
  end
end
