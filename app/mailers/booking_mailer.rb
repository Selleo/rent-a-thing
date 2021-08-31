class BookingMailer < ApplicationMailer
  default from: "notifications@rent-a-thing.com"

  def customer_confirmation
    @booking = params[:booking]
    mail(to: @booking.customer.email, subject: 'Potwierdzenie rezerwacji')
  end

  def owner_confirmation
    @booking = params[:booking]
    mail(bcc: AdminUser.all.pluck(:email), subject: "Potwierdzenie rezerwacji: #{@booking.customer.full_name}")
  end
end
