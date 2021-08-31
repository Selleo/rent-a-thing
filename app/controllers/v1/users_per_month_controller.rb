module V1
  class UsersPerMonthController < ActionController::API
    include Helpers

    def show
      customer_count = 0
      result = generate_months(Customer.first_created.created_at).map do |month|
        customer_count += Customer.in_month(month).count

        { category: month.strftime('%Y-%m'), value: customer_count }
      end

      render json: chart_result('Users per Month', result)
    end
  end
end
