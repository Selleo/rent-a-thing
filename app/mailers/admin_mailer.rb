class AdminMailer < ApplicationMailer
    default from: "notifications@rent-a-thing.com"
           
  
    def admin_confirmation
      @booking = params[:booking]
      mail(to: params[:email], subject: 'Potwierdzenie rezerwacji')
    end

end