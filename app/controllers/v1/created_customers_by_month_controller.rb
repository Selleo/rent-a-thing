module V1
  class CreatedCustomersByMonthController < ActionController::API
    def show
      created_customers_by_month = Customer.all.order(:created_at).
        group_by { |customer| customer.created_at.strftime "%Y-%m" }.
        transform_values { |customers| customers.count }


    result = (created_customers_by_month).map do |month|
      {
        'category' => month[0],
        'value' => month[1]
      }
    end

    render json: {
      data: {
        attributes: {
          name: 'Booked days by month',
          value: result
        }
      }
    }
    end
  end
end

