class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end
  def show
    @booking = Booking.find(params[:id])
  end
=begin
  def destroy
    @booking_delete = Booking.find(params[:id]).destroy
  end
=end
end
