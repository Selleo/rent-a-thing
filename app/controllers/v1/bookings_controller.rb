module V1
  class BookingsController < ActionController::API
    def create

      # binding.pry
      if params.fetch(:starts_on)<Date.current.strftime("%Y-%m-%d") || params.fetch(:starts_on)>params.fetch(:ends_on) || params.fetch(:customer_name).empty? || params.fetch(:customer_phone).empty?
        # binding.pry
        return head :bad_request
      end

      if params.fetch(:item_ids)[0].empty?
        return head :bad_request
      end

      customer = Customer.first_or_create(full_name: params[:customer_name], phone: params[:customer_phone])

      items = Item.find(params.fetch(:item_ids))

      items.map do |item|
        item.bookings.any? do |booking|
          booking_dates = (booking.starts_on..booking.ends_on)
          query_dates = (Date.parse(params.fetch(:starts_on))..Date.parse(params.fetch(:ends_on)))
          if booking_dates.overlaps?(query_dates)
            return head :conflict
          end
        end
      end

      booking = Booking.create(starts_on: params[:starts_on], ends_on: params[:ends_on], customer_id: customer.id, items: items)

      items_names = items.map do |item|
        item.name
      end.join(', ')

      res = params.slice(:customer_name, :customer_phone, :ends_on, :starts_on).merge(booking_id: booking.id, booked_items: items_names)

      render status: :created, json: res
    end
  end
end