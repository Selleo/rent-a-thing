class V1::BookingsCreationController < ActionController::API
  def create
    return bad_request if Date.parse(params[:starts_on]) < Date.today
    return bad_request if Date.parse(params[:starts_on]) > Date.parse(params[:ends_on])
    return bad_request if params[:item_ids].first == ''

    customer = Customer.create(
      full_name: params[:customer_name],
      phone: params[:customer_phone]
    )

    booking = Booking.new(
      customer_id: customer.id,
      starts_on: params[:starts_on],
      ends_on: params[:ends_on]
    )

    booking_query_dates = (Date.parse(params[:starts_on])..Date.parse(params[:ends_on]))

    items = Item.find(params[:item_ids])

    any_item_overlaps = false
    items.each do |i|
      next unless i.bookings.count > 0

      i.bookings.each do |b|
        item_booking_dates = (b.starts_on..b.ends_on)
        any_item_overlaps = true if item_booking_dates.overlaps?(booking_query_dates)
      end
    end
    if any_item_overlaps
      booking.destroy
      customer.destroy
      return render json: { message: 'Conflict' }, status: 409
    end
    booking.items = items

    booking.save!
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
