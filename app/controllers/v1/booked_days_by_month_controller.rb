module V1
  class BookedDaysByMonthController < ActionController::API
    def show
      bookings_length_by_month = Booking.
        where(created_at: Date.current.all_year).
        group_by{ |booking| booking.created_at.month }.
        transform_values do |bookings|
          bookings.sum do |booking|
            (booking.ends_on - booking.starts_on).to_i
          end
      end

      result = (1..Date.current.month).map do |month|
        {
          'month' => Date.new(Date.current.year, month).strftime("%Y-%m"),
          'value' => bookings_length_by_month[month] || 0
        }
      end

      render json: result
    end
  end
end
