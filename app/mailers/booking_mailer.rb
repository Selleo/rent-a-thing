class BookingMailer < ApplicationMailer
  default from: 'notifications@rent-a-thing.com'

  def customer_confirmation
    @booking = params[:booking]
    mail(to: @booking.customer.email, subject: 'Potwierdzenie rezerwacji')
  end

  def mail_admins
    @booking = params[:booking]
    @admin_user = params[:admin_user]
    mail(to: @admin_user.email, subject: '[Admin] Nowa Rezerwacaja')
  end
end
