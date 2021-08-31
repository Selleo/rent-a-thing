module V1
  class BookingsByItemController < ActionController::API
    def show
      result = Item.all.filter { |item| item.bookings.count.positive? }.map do |item|
        { category: item.name, value: item.bookings.count }
      end

      render json: {
        data: {
          attributes: {
            name: 'Bookings by Item',
            value: result
          }
        }
      }
    end
  end
end
