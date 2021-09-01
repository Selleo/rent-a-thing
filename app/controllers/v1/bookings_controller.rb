module V1
  class BadRequestError < StandardError
  end

  class BookingsController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :item_not_found
    rescue_from BadRequestError, with: :render_bad_request
    rescue_from ActiveRecord::RecordInvalid, with: :render_conflict

    def create
      if Date.parse(params[:starts_on]) <= Date.current ||
        Date.parse(params[:ends_on]) <= Date.parse(params[:starts_on]) ||
        params[:customer_name].empty? ||
        params[:customer_phone].empty?
        raise BadRequestError
      end

      customer = Customer.where(full_name: params[:customer_name], phone: params[:customer_phone]).first_or_create

      booking = customer.bookings.create!(starts_on: params[:starts_on], ends_on: params[:ends_on], items: items)

      render json:  params.slice(:customer_name, :customer_phone, :starts_on, :ends_on).merge(
        'booking_id' => booking.id,
        'booked_items' => booking.items.pluck(:name).join(', ')
      ), :status => :created
    end

    private

    def item_not_found
      render json: {error: "One of your items hasn't been found"}, :status => :bad_request
    end

    def render_bad_request
      render json: {error: "Bad request"}, :status => :bad_request
    end

    def render_conflict
      render json: {error: "One of your items has been already booked"}, :status => :conflict
    end

    def items
      @items ||= Item.find(params[:item_ids])
    end
  end
end