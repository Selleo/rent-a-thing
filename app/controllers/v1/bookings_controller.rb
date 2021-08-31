module V1
  class BookingsController < ActionController::API
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
