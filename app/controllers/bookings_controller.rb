class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find_by_uuid(params[:id])

    if @booking.archived_at || @booking.ends_on < Time.current
      render "bookings/404"
    end


  end

  def destroy
    booking = Booking.find_by_id(params[:id])
    booking.archived_at = Time.current
    booking.save
    redirect_to bookings_path, notice: "Booking has been archived successfully"
  end
end
