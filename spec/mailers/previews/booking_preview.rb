# Preview all emails at http://localhost:3000/rails/mailers/booking
class BookingPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/booking/customer_confirmation
  def customer_confirmation
    BookingMailer.customer_confirmation
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking/admin_confirmation
  def admin_confirmation
    BookingMailer.admin_confirmation
  end

end
