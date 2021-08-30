module V1
  class BookingsByItemController < ActionController::API
    def index
      bookings = Booking.all
      booked_items = bookings.flat_map do |booking|
        booking.items
      end

      items = booked_items.uniq.map do |item|
        {
           category: item.name,
           value: booked_items.select { |booked_item| booked_item.id == item.id }.count
         }
      end


      render json: {
        data: {
          attributes: {
            name: 'Bookings by item',
            value: items
          }
        }
      }
    end
  end
end