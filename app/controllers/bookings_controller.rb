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
    @booking.save!

    flash[:alert] = "Booking has been archived successfully"

    redirect_to bookings_path
  end
end
