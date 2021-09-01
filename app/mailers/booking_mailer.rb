class BookingMailer < ApplicationMailer
  default from: "notifications@rent-a-thing.com"
  layout "mailer"

  def customer_confirmation
    @booking = params[:booking]
    mail(to: @booking.customer.email, subject: 'Potwierdzenie rezerwacji')
  end

  def admin_users_confirmation
    @booking = params[:booking]
    admin_email = AdminUser.pluck(:email)
    mail(to: admin_email, subject: 'Potwierdzenie rezerwacji')
  end

  def notification_about_archiving
    @booking = params[:booking]
    admin_email = AdminUser.pluck(:email)
    mail(to: [admin_email, @booking.customer.email], subject: 'Powiadomienie o archiwizacji')
  end

end
