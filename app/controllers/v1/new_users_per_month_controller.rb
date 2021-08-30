class V1::NewUsersPerMonthController < ActionController::API
  def show
    # result = Customer.all.group_by { |customer| customer.created_at.strftime("%Y-%m") }.map { |key, value|
    #   { category: key, value: value.count }
    # }
    all_customers = Customer.all

    first_user_created = Customer.first.created_at
    result = (first_user_created.year..Date.current.year).map do |year|
      (1..[Date.current.month, 12].min).map { |month|
        date = Date.new(year, month)
        { category: date.strftime("%Y-%m"), value: all_customers.where(created_at: date.all_month).count}
      }
    end.flatten

    render json: {
      data: {
        attributes: {
          name: 'Bookings by item',
          value: result
        }
      }
    }
  end
end
