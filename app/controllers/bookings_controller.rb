class BookingsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :error_render_method

  def error_render_method
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.available.find(params[:id])
  end

  def destroy
    booking = Booking.available.find(params[:id])
    booking.update_attribute(:archived_at, Time.current)
    flash[:notice] = "Booking (ID: #{booking.id}) has been successfully archived"
    notify_about_archiving(booking, booking.customer)
    AdminUser.where(mail_notifications: true).each do |admin_user|
      notify_about_archiving(booking, admin_user)
    end
    redirect_to bookings_path
  end

  def notify_about_archiving(b, u)
    BookingMailer.with(booking: b, user: u).notify_about_archiving.deliver_now
  end
end
