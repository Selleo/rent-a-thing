class V1::BookingConfirmationController < ApplicationController
  def show
    @booking = Booking.available.find(params[:id])
    return if @booking.confirmed == true

    @booking.confirmed = true
    @booking.save!
    BookingMailer.with(booking: @booking).customer_confirmation.deliver_now
    AdminUser.where(mail_notifications: true).each do |user|
      BookingMailer.with(admin_user: user, booking: @booking).mail_admins.deliver_now
    end
  end
end
