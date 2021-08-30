module V1 
    class NewCustomersByMonthController < ActionController::API
        def index
            customers = Customer.all
            models = Hash.new(0)
            first_date = customers[0].created_at
            last_date = customers[0].created_at
            customers.each do |customer|
                if first_date > customer.created_at
                    first_date = customer.created_at
                end
                if last_date < customer.created_at
                    last_date = customer.created_at
                end
            end
            months = (first_date.to_datetime..last_date.to_datetime).map do |date|
                Date.new(date.year, date.month, 1)
            end.uniq

            result = {}

            months.each do |month|
                result[month.strftime('%b, %Y')] = 0
            end

            customers.each do |customer|
                date = customer.created_at.to_datetime.strftime('%b, %Y')
                result[date] += 1
            end

            

            formatted_result = []
            result.map do |key,value|
                formatted_result << {"category": key, "value": value}
            end


            render json: {
                data: {
                    attributes: {
                        name: "bookings by item",
                        value: formatted_result
                    }
                }
            }
        end
    end
end