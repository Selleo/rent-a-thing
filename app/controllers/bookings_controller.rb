class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end
  def show
    @booking = Booking.find(params[:id])
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.update_attribute(:archived_at, Time.current)
    flash[:notice]= "archived"
    redirect_to bookings_path

  end
end
