module V1
  class BookingsByItemController < ActionController::API
    def show
      result = Item.all.map do |item|
        {
          category: item.name,
          value: item.bookings.count
        }
      end

      result = result.reject do |row|
        row[:value].zero?
      end

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
