class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find_by(uuid: params[:id]) || @booking.ends_on < Time.current
    if @booking.archived_at != nil
      render :status => 404, :file => "#{Rails.root}/public/404.html", :layout => false
    end
  end

  def destroy
    booking = Booking.find_by(uuid: params[:id])
    booking.archived_at = Time.current
    booking.save
    redirect_to bookings_url, notice: "Booking has been archived"
  end
end
