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
    BookingMailer.with(booking: @booking).notification_about_archiving.deliver_now

    redirect_to bookings_path, notice: 'Booking has been archived successfully.'

  end
end
