module V1
  class ConfirmationsController < ActionController::API
    def create
      Booking.find(params[:id]).touch(:confirmed_at)
    end
  end
end
