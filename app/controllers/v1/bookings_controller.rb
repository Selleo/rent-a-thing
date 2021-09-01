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

    return render json: booking if booking.present?

    params[:item_ids].each do |item_id|
      booking.items << Item.find(item_id)
    end

    head :created
  end
end
