module V1
  class BookingsByItemController < ActionController::API
    def show
      result = Item.all.filter { |item| item.bookings.count.positive? }.map { |item|
        { category: item.name, value: item.bookings.count }
      }

      render json: {
        data: {
          attributes: {
            name: 'Bookings by item',
            value: result
          }
        }
      }
    end
  end
end
