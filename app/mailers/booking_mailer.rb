class BookingMailer < ApplicationMailer
  default from: "notifications@rent-a-thing.com"

  def customer_confirmation
    @booking = params[:booking]
    mail(to: @booking.customer.email, subject: 'Potwierdzenie rezerwacji')
  end
end
