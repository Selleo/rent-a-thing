class V1::ItemsAvailableController < ApplicationController::API
 def index
   # binding.pry   i podajesz params w konsoli 
    # @items = Item.all
    #bookings
    # find bookings witch overlap provided dates range

    Booking.all.select do |booking|        #definiowanie zakresu   
     booking_dates =(booking.starts_on..booking.ends_on)
     query_dates = (Date.parse(params.fetch(:start_date))..)date.parse(params.fetch(:end_date))
     booking_dates.overlaps?(query_dates)
    end

    items = bookings.flat_map do |booking|
        booking.items
    end.unique   


    available_items = Item.where.not(id: booked_items.map(&:id))


    render json: @items
 end

 def show
 end 

end

