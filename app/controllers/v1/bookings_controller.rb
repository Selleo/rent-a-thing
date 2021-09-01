module V1
  class BadRequestError < StandardError
  end

  class BookingsController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :item_not_found
    rescue_from BadRequestError, with: :render_bad_request

    def create
      if Date.parse(params[:starts_on]) <= Date.current ||
        Date.parse(params[:ends_on]) <= Date.parse(params[:starts_on]) ||
        params[:customer_name].empty? ||
        params[:customer_phone].empty?
        raise BadRequestError
      end

      items = Item.find(params[:item_ids])

      bookings = Booking.all.select do |booking|
        booking_dates = (booking.starts_on..booking.ends_on)
        query_dates = (Date.parse(params.fetch(:starts_on))..Date.parse(params.fetch(:ends_on)))
        booking_dates.overlaps?(query_dates)
      end

      # aggregate items for those bookings
      booked_items = bookings.flat_map do |booking|
        booking.items
      end.uniq

      all_available = true
      items.each do |item|
        if item.in?(booked_items)
          all_available = false
          break
        end
      end

      if !all_available
        return render json: {error: "One of your items has been already booked"}, :status => :conflict
      end

      customer = Customer.find_by(full_name: params[:customer_name], phone: params[:customer_phone])
      if !customer
        customer = Customer.create(full_name: params[:customer_name], phone: params[:customer_phone])
        customer.save!
      end

      booking = Booking.create(customer_id: customer.id, starts_on: params[:starts_on], ends_on: params[:ends_on], items: items)
      booking.save!

      render json: {
        'booking_id' => booking.id,
        'customer_name' => customer.full_name,
        'customer_phone' => customer.phone,
        'starts_on' => booking.starts_on,
        'ends_on' => booking.ends_on,
        'booked_items' => booking.items.map {|item| item.name}.join(', ')
      }, :status => :created
    end

    private

    def item_not_found
      render json: {error: "One of your items hasn't been found"}, :status => :bad_request
    end

    def render_bad_request
      render json: {error: "Bad request"}, :status => :bad_request
    end
  end
end