class V1::BookingsCreationController < ActionController::API
      def create
        booking = Booking.create(
          customer_name: params[:customer_name],
          customer_phone: params[:customer_phone],
          starts_on: params[:starts_on],
          ends_on: params[:ends_on],
          item_ids: params[:item_ids],
        )
      end
end