module V1
  class NewUsersPerMonthController < ActionController::API
    include Helpers

    def show
      result = generate_months(Customer.first_created.created_at).map do |month|
        customers_count = Customer.in_month(month).count
        { category: month.strftime('%Y-%m'), value: customers_count }
      end

      render json: {
        data: {
          attributes: {
            name: 'New Users',
            value: result
          }
        }
      }
    end
  end
end
