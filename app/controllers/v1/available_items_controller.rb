module V1
  class AvailableItemsController < ActionController::API
    def index
      # items
      # bookings
      # find bookings which overlap provided dates range

      bookings = Booking.all.select do |booking|
        bookings_dates = (booking.starts_on..booking.ends_on)
        params_range = (Date.parse(params.fetch(:start_date))..Date.parse(params.fetch(:end_date)))
        #  using fetch because it will throw Exception hinting what params did we actually mean
        bookings_dates.overlaps?(params_range)

      end
      # aggregate items for those bookings

      booked_items = bookings.flat_map do |booking|
        booking.items
      end.uniq
      # return all items but those aggregated

      available_items = Item.where.not(id: booked_items.map(&:id))

      # binding.pry
      render json: available_items.as_json(only: [:id, :name, :description])
    end
  end
end