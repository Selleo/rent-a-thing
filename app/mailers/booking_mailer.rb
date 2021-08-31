class BookingMailer < ApplicationMailer
default from: 'rent-a-hing@dot.com
'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.customer_confirmation.subject
  #

  def customer_confirmation
    
 #   @booking = params[:booking]
 
  # mail(to: @booking.customer.email, subject: 'Potwierdzenie rezerwacji')
 end


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.admin_confirmation.subject
  # 
    def admin_confirmation
     
      @sss= params[:emails]
      @booking = params[:booking]
      #mail(to: @sss[0], cc: @sss[1..-1], subject: 'Potwierdzenie rezerwacji')
       mail(bcc: @sss, subject: 'Potwierdzenie rezerwacji')
  end

end
