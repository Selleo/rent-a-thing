class V1::BookingsController < ActionController::API
  def create
    if booking_is_in_the_past? || items_not_passed? || customer_attributes_blank?
      return render json: {}, status: :bad_request
    end

    if booking.new_record?
      return render json: {}, status: :conflict if item_overlaps_booking?

      booking.items = items
      booking.save!
    end

    render json: {
      customer_name: customer.full_name,
      customer_phone: customer.phone,
      booking_id: booking.id,
      booked_items: booking.items.map(&:name).join(', '),
      starts_on: booking.starts_on,
      ends_on: booking.ends_on
    }, status: :created
  end

  private

  def customer
    @customer ||= Customer.where(email: params[:customer_email]).first_or_create(
      full_name: params[:customer_name],
      phone: params[:customer_phone]
    )
  end

  def booking
    @booking ||= customer.bookings.where(
      starts_on: params[:starts_on].to_date,
      ends_on: params[:ends_on].to_date
    ).first_or_initialize
  end

  def items
    @items ||= Item.where(id: params[:item_ids])
  end

  def booking_is_in_the_past?
    params[:starts_on].to_date < Date.current || params[:ends_on].to_date < params[:starts_on].to_date
  end

  def items_not_passed?
    params[:item_ids].any?(&:blank?)
  end

  def customer_attributes_blank?
    params[:customer_name].blank? || params[:customer_phone].blank?
  end

  def item_overlaps_booking?
    new_booking_range = booking.starts_on..booking.ends_on

    items.flat_map(&:bookings).any? do |booking|
      new_booking_range.overlaps?(booking.starts_on..booking.ends_on)
    end
  end
end
