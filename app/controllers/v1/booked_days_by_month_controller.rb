module V1
  class BookedDaysByMonthController < ActionController::API
    def index
      year = params[:year] ? params[:year].to_i : Time.now.year
      month = params[:year] ? 12 : Time.now.month

      months = []
      (1..month).each do |month|
        month = Date.new(year, month).strftime("%Y-%m")
        days = 0
        Booking.for_month(month).each do |booking|
          days += (booking.ends_on - booking.starts_on).to_i
        end
        months.append({
          :month => month,
          :value => days
        })
      end


      render json: months
    end
  end
end
