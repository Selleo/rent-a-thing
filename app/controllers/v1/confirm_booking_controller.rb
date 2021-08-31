module V1
  class ConfirmBookingController < ActionController::API
    def index
      booking = Booking.find(params[:id])
      booking.confirmed = true
      booking.save!
      BookingMailer.with(booking: booking).customer_confirmation.deliver_now
      redirect_to '/'
    end
  end
end