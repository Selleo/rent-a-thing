module V1
  class BookedBikesController < ActionController::API

    def show
      result = []
      Item.all.each do |item|
        result << {
          category: item.name,
          value: item.bookings.count
        }
      end
      
      res = result.reject { |element| element[:value] == 0 }

      render json: {
        data: {
          attributes: {
            name: 'Bikes bookings',
            value: res
          }
        }
      }
    end

  end
end
