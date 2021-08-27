class BookingsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :show_404

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.active.find(params[:id])
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.update(archived_at: Time.current)
    redirect_to bookings_path, notice: "Booking has been archived successfully"
  end

  def show_404
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end

end
