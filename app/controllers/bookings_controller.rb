class BookingsController < ApplicationController
  
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
    if @booking.ends_on > Time.current || !@booking.archived_at.nil?
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.update_attribute(:archived_at, Time.current)
    flash[:notice] = "Booking (ID: #{booking.id}) has been successfully archived"
    redirect_to bookings_path
  end
end
