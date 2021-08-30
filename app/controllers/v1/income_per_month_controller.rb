module V1
  class IncomePerMonthController < ActionController::API
    def show
      all_bookings = Booking.all

      first_booking_created = Booking.first.created_at
      result = (first_booking_created.year..Date.current.year).flat_map do |year|

        (1..[Date.current.month, 12].min).flat_map { |month|
          date = Date.new(year, month)
          income = all_bookings.where(created_at: date.all_month).sum { |booking|
            price_per_day = booking.items.sum(&:price_per_day)
            days = [1, (booking.ends_on - booking.starts_on).to_i].max

            price_per_day * days
          }
          { category: date.strftime("%Y-%m"), value: income.to_f }
        }

      end

      render json: {
        data: {
          attributes: {
            name: 'Income per month',
            value: result
          }
        }
      }
    end
  end
end
