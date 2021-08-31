module V1
<<<<<<< Updated upstream
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
=======
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
  
>>>>>>> Stashed changes
