class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    # if Bookings(archived_at) !== nil
    # render '404'
    # else
      @booking = Booking.find(params[:id])
    # end
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.update(archived_at: Time.current)
    redirect_to bookings_path, notice: "Booking has been archived successfully"
  end



end
