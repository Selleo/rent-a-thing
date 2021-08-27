class V1::Statistics::BookedDaysByMonthController < ApplicationController
  def index
    @months = []
    #@items = Booking.all
    #render json: @items
    currentmonth = Date.today.month.to_int
    @miesionce = Date::MONTHNAMES
    
    currentmonth.times do |month| 
        @months << @miesionce[month+1]
    end

   render json: @months
  end

  def show
  end


end
