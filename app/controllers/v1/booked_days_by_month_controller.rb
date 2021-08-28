module V1
  class InvalidYearError < StandardError
  end

  class BookedDaysByMonthController < ActionController::API
    rescue_from InvalidYearError, with: :throw_400_status

    def index
      if params[:year] && (!/\A\d+\z/.match(params[:year]) || params[:year].to_i >= Time.now.year)
        raise InvalidYearError
      end

      current_year = params[:year] ? params[:year].to_i : Time.now.year
      current_month = params[:year] ? 12 : Time.now.month

      months = []
      (1..current_month).each do |month|
        month = Date.new(current_year, month).strftime("%Y-%m")
        months.append({
          :month => month,
          :value => Booking.created_in_month(month).count
        })
      end

      render json: months
    end

    def throw_400_status
      render json: {:error => "Invalid parameter error"}, status: :bad_request
    end
  end
end
