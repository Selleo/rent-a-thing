class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end
  def show
      @booking=Booking.find(params[:id])
  end
  def destroy
    @booking=Booking.find(params[:archived_at]).update(Time.now)
  end
end
