
class BookingMailer < ApplicationMailer
  default from: "notifications@rent-a-thing.com"
  
  def routes
    Rails.application.routes.url_helpers
  end

  def customer_confirmation
    @booking = params[:booking]
    @url = routes.booking_path(@booking)
    mail(to: @booking.customer.email, subject: 'Potwierdzenie rezerwacji')
  end

  def new_booking
    @booking = params[:booking]
    admins = AdminUser.all 
    admins.map do |admin|
      if admin.is_getting_notifications == nil
        mail(to: admin.email, subject: 'rezerwacja została anulowana') do |format|
          format.html { render 'archive_booking' }
        end
      end
      if admin.is_getting_notifications == true
        mail(to: admin.email, subject: 'rezerwacja została anulowana') do |format|
          format.html { render 'archive_booking' }
        end
      end
    end
  end

  def archive_booking
    @booking = params[:booking]
    customer = @booking.customer
    mail(to: customer.email, subject: 'rezerwacja została anulowana') do |format|
      format.html { render 'archive_booking' }
    end
    admins = AdminUser.all 
    admins.map do |admin|
      if admin.is_getting_notifications == nil
        mail(to: admin.email, subject: 'rezerwacja została anulowana') do |format|
          format.html { render 'archive_booking' }
        end
      end
      if admin.is_getting_notifications == true
        mail(to: admin.email, subject: 'rezerwacja została anulowana') do |format|
          format.html { render 'archive_booking' }
        end
      end
    end
  end
end
