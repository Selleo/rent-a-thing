class BookingMailer < ApplicationMailer
  default from: 'rent-a-thing@example.com'

  def notify_admin
    @booking = params[:booking]

    AdminUser.all.each do |admin|
      mail(to: admin.email, subject: "A new reservation was placed.")
    end

  def customer_confirmation
    @booking = params[:booking]
    mail(to: @booking.customer.email, subject: 'Potwierdzenie rezerwacji')
  end
end
