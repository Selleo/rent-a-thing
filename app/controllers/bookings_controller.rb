class BookingsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :status404

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.with_not_archived.with_end_on_before_current.find(params[:id])
    # if @booking.archived_at != nil || @booking.ends_on < Time.current
    #
    # end
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.archived_at = Time.current
    booking.save
    redirect_to bookings_url, notice: "Booking has been archived"
  end

  def status404
    render :status => 404, :file => "#{Rails.root}/public/404.html", :layout => false
  end
end
