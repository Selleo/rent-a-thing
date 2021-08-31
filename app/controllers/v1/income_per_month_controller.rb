module V1
  class IncomePerMonthController < ActionController::API
    include Helpers

    def show
      result = generate_months(Booking.first_to_start.starts_on).map do |month|
        income = Booking.in_month(month).sum do |booking|
          price_per_day = booking.items.sum(&:price_per_day)

          (price_per_day * booking.booked_days).to_f
        end

        { category: month.strftime('%Y-%m'), value: income }
      end

      render json: {
        data: {
          attributes: {
            name: 'Income per Month',
            value: result
          }
        }
      }
    end
  end
end
