module V1
  class ItemsByBookingNumberController < ActionController::API
    def show

       items_with_booking_number = Item.all.map { |item|{'category' =>item.name, 'value' => item.bookings.count} }


      render json: {
        data: {
          attributes: {
            name: 'Items by booking number',
            value: items_with_booking_number
          }
        }
      }
    end
  end
end
