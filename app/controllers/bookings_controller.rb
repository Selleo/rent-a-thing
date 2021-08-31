class BookingsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.not_archived.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.is_confirmed = true
    @booking.save!

    flash[:alert] = "Booking has been successfully confirmed"
    BookingMailer.with(booking: @booking).notify_admin.deliver_now

    redirect_to bookings_path
  end

  def destroy
    @booking = Booking.not_archived.find(params[:id])
    @booking.archived_at = Time.current
    @booking.save!

    flash[:alert] = "Booking has been archived successfully"

    BookingMailer.with(booking: @booking).archive_notification.deliver_now

    redirect_to bookings_path
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: 404
  end
end
