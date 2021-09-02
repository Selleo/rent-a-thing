module V1
  class NewCustomersByMonthController < ActionController::API
    def show
      new_customer_by_month = Customer.
        order(:created_at).
        group_by { |customer| customer.created_at.strftime('%b %Y') }.
        transform_values(&:count)

      month = Customer.minimum(:created_at).beginning_of_month
      result = []

      while month < Date.current
        month_formatted = month.strftime('%b %Y')
        result << {
          category: month_formatted,
          value: new_customer_by_month.fetch(month_formatted, 0)
        }
        month = month + 1.month
      end

      render json: {
        data: {
          attributes: {
            name: 'New customers by month',
            value: result
          }
        }
      }
    end
  end
end
