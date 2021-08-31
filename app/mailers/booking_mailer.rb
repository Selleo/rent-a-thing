class BookingMailer < ApplicationMailer
  default from: 'rent-a-thing@example.com'

  def notify_admin
    @booking = params[:booking]
    mail(bcc: params[:recipients], subject: 'A new reservation was placed.')
  end

  def customer_confirmation
    @booking = params[:booking]
    mail(to: @booking.customer.email, subject: 'Potwierdzenie rezerwacji')
  end

  def archive_notification
    @booking = params[:booking]
    @for_admin = params[:for_admin] || false

    mail(bcc: params[:recipients], subject: 'Reservation was archived.')
  end
end
