class V1::Statistics::BookedDaysByMonthController < ApplicationController
  # def index
  #   @months = []
  #   currentmonth = Date.today.month.to_int
  #   # @miesionce = Date::MONTHNAMES
    
  #   currentmonth.times do |month| 
  #       @months << @miesionce[month+1]
  #   end

  #  render json: @months
  # end

  # def show
  # end
  def index
    answer_hash = Booking.all
      .group_by{ |b| b.starts_on.strftime("%Y-%m") }
      .transform_values do |bookings| 
        bookings.sum{ |booking| (booking.ends_on - booking.starts_on).to_i }
      end    

    year = params.fetch("year", Date.current.year.to_s)
    current_month_int = Date.today.month
    if year.to_i < Date.today.year
      current_month_int = 12
    end
    answer_array = []

    current_month_int.times do | month_int |
      month_id = "#{year}-#{(month_int+1).to_s.rjust(2, "0")}"
      temp_hash = { "month": month_id }
      if !answer_hash[month_id].nil?
        temp_hash["value"] = answer_hash[month_id]
      else
        temp_hash["value"] = 0
      end
      answer_array.push(temp_hash)
    end

    render json: answer_array
  end

end
