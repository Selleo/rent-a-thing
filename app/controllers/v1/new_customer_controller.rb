module V1
    class NewCustomerController < ActionController::API
      def show
        result = Customer.all.group_by {|customer| customer.created_at.month }.
        map {|key, radek| {category: key, value: radek.size } }
      

        render json: {
          data: {
            attributes: {
              name: 'new_customer',
              value: result
            }
          }
        }
      end
    end
end
  