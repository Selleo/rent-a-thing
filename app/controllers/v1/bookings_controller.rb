module V1
  class BookingsController < ActionController::API
    def create
      customer = Customer.create(full_name: params[:customer_name], phone: params[:customer_phone])
      booking = Booking.create(starts_on: params[:starts_on], ends_on: params[:ends_on], customer_id: customer.id)

      items = params[:item_ids].map do |item_id|
        BookedItem.create(item_id: item_id, booking_id: booking.id)
        Item.find(item_id).name
      end
      
      render status: :created, json: {
        "booked_items": items.join(', '),
        "booking_id": booking.id,
        "customer_name": customer.full_name,
        "customer_phone": customer.phone,
        "ends_on": booking.ends_on,
        "starts_on": booking.starts_on
      }
    end
  end
end