module V1
  class BookingsController < ActionController::API
    def create
      booking = Booking.new(
        starts_on: params[:starts_on],
        ends_on: params[:ends_on]
        )
      customer = Customer.new(
        full_name: params[:customer_name],
        phone: params[:customer_phone]
      )
      customer.save
      booking.customer = customer
      booking.items = Item.find(params[:item_ids])
      booking.save

      render json: {
        booking_id: booking.id,
        customer_name: customer.full_name,
        customer_phone: customer.phone,
        starts_on: booking.starts_on,
        ends_on: booking.ends_on,
        booked_items: booking.items[0].name
      }, status: 201
    end
  end
end