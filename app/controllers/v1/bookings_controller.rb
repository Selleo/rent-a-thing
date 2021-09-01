class V1::BookingsController < ActionController::API
  def create
    if params.require(:item_ids)
      return render html: "empty_item_ids", status: :bad_request
    end

    customer = Customer.find_or_create_by!(
      full_name: params[:customer_name],
      email: params[:customer_email],
      phone: params[:customer_phone]
    )

    booking = customer.bookings.find_by(
      starts_on: params[:starts_on].to_date,
      ends_on: params[:ends_on].to_date,
      archived_at: nil
    )

    unless booking.present?
      booking = customer.bookings.create!(
        starts_on: params[:starts_on].to_date,
        ends_on: params[:ends_on].to_date
      )

      params[:item_ids].each do |item_id|
        item = Item.find(item_id)

        if item.bookings.where(starts_on: booking.starts_on..booking.ends_on).present? ||
          item.bookings.where(ends_on: booking.starts_on..booking.ends_on).present?

          booking.destroy!
          return render html: 'item_conflict', status: 409
        end

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
