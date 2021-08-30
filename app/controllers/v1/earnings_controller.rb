module V1
  class EarningsController<ActionController::API
    def show
      bookings_earning_by_month = Booking.all
                                         .group_by{ |booking| booking.created_at.strftime("%Y-%m")   }.
        transform_values do |bookings|
        bookings.sum do |booking|
          days = (booking.ends_on - booking.starts_on).to_i + 1
          booking.items.sum do |item|
            item.price_per_day * days
          end
        end
      end

      res=bookings_earning_by_month.map{|k,v|{category:k,value:v}}

      render json: {
        data: {
          attributes: {
            name: 'Earnings by month',
            value: res
          }
        }
      }
    end
    end
  end

