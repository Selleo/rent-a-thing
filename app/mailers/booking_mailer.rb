class BookingMailer < ApplicationMailer
  default from: "notifications@rent-a-thing.com"
<<<<<<< HEAD
  layout "mailer"
=======
>>>>>>> aadcb3c766d512b0f3d592c80c5381c25a08f4eb

  def customer_confirmation
    @booking = params[:booking]
    mail(to: @booking.customer.email, subject: 'Potwierdzenie rezerwacji')
  end
<<<<<<< HEAD

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

=======
>>>>>>> aadcb3c766d512b0f3d592c80c5381c25a08f4eb
end
