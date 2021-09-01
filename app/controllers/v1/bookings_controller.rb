class V1::BookingsController < ActionController::API
  def create
    customer = Customer.find_or_create_by!(
      full_name: params[:customer_name],
      email: params[:customer_email],
      phone: params[:customer_phone]
    )

    booking = customer.bookings.find_or_create_by!(
      starts_on: params[:starts_on].to_date,
      ends_on: params[:ends_on].to_date,
      archived_at: nil
    )

    if !booking.booked_items.present?
      params[:item_ids].each do |item_id|
        booking.items << Item.find(item_id)
      end
    end

    render json: {
      customer_name: customer.full_name,
      customer_phone: customer.phone,
      booking_id: booking.id,
      booked_items: booking.booked_items.map { |booked_item| booked_item.item.name }.join(', ')
    }.merge(booking.as_json(only: %i[starts_on ends_on])), status: :created

  end
end
