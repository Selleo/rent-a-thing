module V1
  class BookingsApiController < ActionController::API
    def index
      if params[:year].present?
        return render json: { error: "invalid_value" }, status: 400 if !/^\d{4}$/.match?(params[:year])
        filter_date = Date.new(params[:year].to_i, 12)
      else
        filter_date = Date.current
      end

      filtered_bookings = Booking.where(created_at: filter_date.all_year).group_by { |booking| booking.starts_on.month }
      result = (1..filter_date.month).map do |month|
        bookings = filtered_bookings[month] || []
        days_booked = bookings.sum { |booking| (booking.ends_on - booking.starts_on).to_i }
        { month: Date.new(filter_date.year, month).strftime("%Y-%m"), value: days_booked }
      end

      render json: result
    end
  end
end
