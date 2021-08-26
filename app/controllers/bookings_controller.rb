class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end
  def show
    @booking = Booking.find(params[:id])
  end
  def destroy
    @booking = Booking.find(params[:id])
    @booking.archived_at = Time.current
    # redirect_to index
  end
end
