class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.archived_at = Time.current
    booking.save
    redirect_to bookings_url, notice: "Booking has been archived"
  end
end
