class V1::BookingsCreationController < ActionController::API
  def create
    # Validate Request
    return bad_request if Date.parse(params[:starts_on]) < Date.today
    return bad_request if Date.parse(params[:starts_on]) > Date.parse(params[:ends_on])
    return bad_request if params[:item_ids].first == ''
    return bad_request if params[:customer_name].empty?
    return bad_request if params[:customer_phone].empty?

    # Validate Items Overlaps
    items = Item.find(params[:item_ids])
    booking_query_dates = (Date.parse(params[:starts_on])..Date.parse(params[:ends_on]))
    any_item_overlaps = items.any? do |item|
      item.bookings.any? do |booking|
        (booking.starts_on..booking.ends_on).overlaps?(booking_query_dates)
      end
    end

    # Render Error if any item failed above validation
    return render json: { message: 'Conflict' }, status: 409 if any_item_overlaps

    # Create Persistent Objects
    customer = Customer.where(
      full_name: params[:customer_name],
      phone: params[:customer_phone]
    ).first_or_create

    booking = customer.bookings.create(
      starts_on: params[:starts_on],
      ends_on: params[:ends_on],
      items: items
    )

    # Render Output
    render json: {
      'booking_id': booking.id,
      'customer_name': booking.customer.full_name,
      'customer_phone': booking.customer.phone,
      'starts_on': booking.starts_on,
      'ends_on': booking.ends_on,
      'booked_items': booking.items.map(&:name).join(', ')
    }, status: 201
  end

  def bad_request
    render json: { message: 'Bad Request' }, status: 400
  end
end
