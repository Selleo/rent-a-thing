class BookingsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, :with => :error_render_method
  def index
    @bookings = Booking.all
  end
  def show
     # if @booking.is_archived?
    #      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
     # else
    #       @booking = Booking.find(params[:id])#do nothing, which means render standard show template
    #  end
    @booking = Booking.active.find(params[:id])


  end
  def destroy
      booking = Booking.find(params[:id])
      booking.update_attribute(:archived_at, Time.current)
      flash[:notice] = "Booking has been archived successfully"
      redirect_to bookings_path
  end
  def error_render_method
    # render :file => "#{RAILS_ROOT}/public/404.html",  :status => 404
     render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
    end


end
