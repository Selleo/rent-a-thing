class V1::BookingsCreationController < ActionController::API
  def create
    customer = Customer.create(
      full_name: params[:customer_name],
      phone: params[:customer_phone]
    )

    booking = Booking.create(
      customer_id: customer.id,
      starts_on: params[:starts_on],
      ends_on: params[:ends_on]
    )

    items = Item.find(params[:item_ids])
    booking.items = items

    render json: {
      'booking_id': booking.id,
      'customer_name': booking.customer.full_name,
      'customer_phone': booking.customer.phone,
      'starts_on': booking.starts_on,
      'ends_on': booking.ends_on,
      'booked_items': booking.items.map(&:name).join(', ')
    }, status: 201
  end
end
