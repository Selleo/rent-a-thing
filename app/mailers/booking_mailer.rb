class BookingMailer < ApplicationMailer
  default from: 'rent-a-thing@example.com'

  def notify_admin
    @booking = params[:booking]

    AdminUser.all.each do |admin|
      mail(to: admin.email, subject: 'A new reservation was placed.')
    end
  end

  def customer_confirmation
    @booking = params[:booking]
    mail(to: @booking.customer.email, subject: 'Potwierdzenie rezerwacji')
  end

  def archive_notification
    @booking = params[:booking]
    BookingMailer.send_archive_notification(@booking, @booking.customer.email).deliver_now

    @for_admin = true
    AdminUser.all.each do |admin|
      BookingMailer.send_archive_notification(@booking, admin.email, true).deliver_now
    end
  end

  def send_archive_notification(booking, to, for_admin = false)
    @booking = booking
    @for_admin = for_admin
    mail(to: to, subject: 'Reservation was archived.')
  end
end
