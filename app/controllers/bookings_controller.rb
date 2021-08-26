class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
    if !@booking.archived_at.nil? || @booking.ends_on < Time.current
      flash[:alert] = "Not found"
      redirect_to bookings_path
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.archived_at = Time.current
    @booking.save!

    flash[:alert] = "Booking has been archived successfully"

    redirect_to bookings_path
  end
end
