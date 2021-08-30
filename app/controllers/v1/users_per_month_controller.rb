class V1::UsersPerMonthController < ActionController::API
  def show
    all_customers = Customer.all

    first_user_created = Customer.first.created_at
    c = 0
    result = (first_user_created.year..Date.current.year).map do |year|
      (1..[Date.current.month, 12].min).map { |month|
        date = Date.new(year, month)
        c += all_customers.where(created_at: date.all_month).count
        { category: date.strftime("%Y-%m"), value: c }
      }
    end.flatten

    render json: {
      data: {
        attributes: {
          name: 'Users',
          value: result
        }
      }
    }
  end
end