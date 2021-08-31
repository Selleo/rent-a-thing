class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.update(archived_at: Time.current)

    redirect_to bookings_path(@booking), notice: 'Booking has been archived successfully.'
  end




end
