module V1
  class AvailableItemsController < ActionController::API
    def index
      # find bookings which overlap provided dates range
      bookings = Booking.all.select do |booking|
        booking_dates = (booking.starts_on..booking.ends_on)
        query_dates = (Date.parse(params.fetch(:start_date))..Date.parse(params.fetch(:end_date)))
        booking_dates.overlaps?(query_dates)
      end

      # aggregate items for those bookings
      booked_items = bookings.flat_map do |booking|
        booking.items
      end.uniq

      # return all items but those aggregated
      available_items = Item.where.not(id: booked_items.map(&:id))

      render json: available_items.as_json(only: [:id, :name, :description])
    end
  end
