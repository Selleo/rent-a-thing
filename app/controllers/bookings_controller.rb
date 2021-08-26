class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @bookings = Booking.all
  end
end
