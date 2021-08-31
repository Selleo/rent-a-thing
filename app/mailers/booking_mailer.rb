class BookingMailer < ApplicationMailer
  default from: "notifications@rent-a-thing.com"

  def customer_confirmation
    @booking = params[:booking]
    mail(to: @booking.customer.email, subject: 'Potwierdzenie rezerwacji')
  end

  def inform_admin
    @booking = params[:booking]
    @admin_user = params[:admin_user]
    mail(to: @admin_user.email, subject: 'Nowa rezerwacja')
  end
end
