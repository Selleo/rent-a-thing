module V1
  class BookingsByItemController < ActionController::API
    include Helpers

    def show
      result = Item.all.filter { |item| item.bookings.count.positive? }.map do |item|
        { category: item.name, value: item.bookings.count }
      end

      render json: chart_result('Bookings by Item', result)
    end
  end
end
