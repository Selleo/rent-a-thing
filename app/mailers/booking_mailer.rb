class BookingMailer < ApplicationMailer
  default from: 'notifications@rent-a-thing.com'
  layout 'mailer'

  def customer_confirmation
    @booking = params[:booking]
    mail(to: @booking.customer.email, subject: 'Potwierdzenie rezerwacji')
  end

  def mail_admins
    @booking = params[:booking]
    @admin_user = params[:admin_user]
    mail(to: @admin_user.email, subject: '[Admin] Nowa Rezerwacaja')
  end

  def notify_about_archiving
    @booking = params[:booking]
    @user = params[:user]
    mail(to: @user.email, subject: "Booking (id: #{@booking.id}) was archived")
  end

  def confirm_reservation
    @booking = params[:booking]
    mail(to: @booking.customer.email, subject: 'You need to confirm your reservation')
  end
end
