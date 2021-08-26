class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end
  def show
      @booking=Booking.find(params[:id])
  end
  def destroy
    @booking=Booking.find(params[:id]).update(archived_at: Time.current)
    redirect_to bookings_url, notice: 'siema'
  end
  def destroy
    @booking=Booking.find(params[:id]).delete()
    redirect_to bookings_url, notice: 'dfsdf'
  end

end
