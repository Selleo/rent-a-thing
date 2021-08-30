module V1
  class AllCustomersByMonthController < ActionController::API
    def index
      date_range = (Date.new(Customer.minimum(:created_at).year, Customer.minimum(:created_at).month)..Date.current)
      date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
      customers = date_months.map do |month|
        month = month.strftime("%Y-%m")
        {
          category: month,
          value: Customer.customers_in_month(month).count
        }
      end

      render json: {
        data: {
          attributes: {
            name: 'New customers by month',
            value: customers
          }
        }
      }
    end
  end
end