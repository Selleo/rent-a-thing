class BookingsController < ApplicationController
  def index
    @bookings = Booking.all.sort_by { |booking| booking.customer.full_name }
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.update({ archived_at: Time.current })
    redirect_to action: "index"
  end
end
