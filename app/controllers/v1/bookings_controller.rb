module V1
  class BookingsController < ApplicationController
    def index
      @bookings = Booking.all
    end

    def destroy
      @booking = Booking.find(params[:id])
      @booking.update(archived_at: Time.current)
      redirect_to bookings_path, notice: 'Booking has been archived succesfully'
    end

    def show #detail
      @booking = Booking.find(params[:id])
    end

    def create
      customer = Customer.new(full_name: params[:customer_name], phone: params[:customer_phone])
      customer.save!
      booking = Booking.new()
      booking.customer_id = customer.id
      booking.starts_on = params[:starts_on]
      booking.ends_on = params[:ends_on]
      booking.item_ids = params[:item_ids]
      booking.save

      start_date = params[:starts_on]
      end_date = params[:ends_on]

      params[:item_ids].map do |id|
        if BookedItem.where(item_id: id).exists?
          booking = Booking.find(id)
          if (start_date..end_date).everlaps?(booking.starts_on..booking.ends_on)
            status 409
          end
        end
      end

      render json: {
        'booking_id' => booking.id,
        'customer_name' => customer.full_name,
        'customer_phone' => customer.phone,
        'starts_on' => booking.starts_on,
        'ends_on' => booking.ends_on,
        'booked_items' => params[:item_ids].map {|id | Item.find(id).name}.join(", ")
      }, status: 201
    end
  end
end
