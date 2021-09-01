module V1
    class BookingsByItemController < ActionController::API
      def show
      result = Item.all.map {|item|
      {category: item.name, value: item.bookings.count} }

        render json: {
          data: {
            attributes: {
              name: 'bookings_by_item',
              value: result
            }
          }
        }
      end
    end
end
