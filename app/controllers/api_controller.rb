class ApiController < ApplicationController
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
        render json: @months
    end
end
