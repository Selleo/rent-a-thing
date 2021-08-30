module V1 
    class BookingsByItemController < ActionController::API
        def index
            bookings = Booking.all
            models = Hash.new(0)
            bookings.each do |booking|
                if (booking.booked_items.each == []) == false
                    booking.booked_items.each do |bike|
                        bike_name = Item.find(bike.item_id).name
                        models[bike_name] += 1
                    end
                end
            end

            result = []
            models.map do |key,value|
                result << {"category": key, "value": value}
            end



            render json: {
                data: {
                    attributes: {
                        name: "bookings by item",
                        value: result
                    }
                }
            }


        end
    end
end