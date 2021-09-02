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

=begin 
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
=end
   def create
      return head :bad_request if invalid_params?

      customer = Customer.create(
        full_name: params.fetch(:customer_name),
        phone: params.fetch(:customer_phone)
      )

      booking = customer.bookings.build(
        starts_on: params.fetch(:starts_on),
        ends_on: params.fetch(:ends_on)
      )

      items = Item.where(id: params[:item_ids])
      booking.items << items

      return head 409 unless booking.valid?

      booking.save!

      render json: params.
        slice(:customer_name, :customer_phone, :starts_on, :ends_on).
        merge(booking_id: booking.id, booked_items: items.map(&:name).join(', ')),
             status: :created
    end

    private

    def invalid_params?
      blank_items? ||
        starts_on_in_the_past? ||
        starts_on_after_ends_on? ||
        customer_data_missing?
    end

    def starts_on_in_the_past?
      Date.parse(params.fetch(:starts_on)) < Date.current
    end

    def blank_items?
      params.fetch(:item_ids).blank? ||
        params.fetch(:item_ids).any?(&:blank?)
    end

    def starts_on_after_ends_on?
      Date.parse(params.fetch(:starts_on)) > Date.parse(params.fetch(:ends_on))
    end

    def customer_data_missing?
      params.fetch(:customer_phone).blank? ||
        params.fetch(:customer_name).blank?
    end
  end
end
