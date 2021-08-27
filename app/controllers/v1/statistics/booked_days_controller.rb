module V1
    module Statistics
        class BookedDaysController < ActionController::API
            def index
                if params[:year] == nil
                    date_range = (Date.today.beginning_of_year..Date.today)
                else
                    if (1..3000).include?(params[:year].to_i)
                        date_range = (Date.today.beginning_of_year..Date.today)
                        #date_range = (Date.new(params[:year], 1, 1)..)
                    else
                        render json: [], :status => :bad_request
                    end
                end
                months = date_range.map do |date|
                    Date.new(date.year, date.month, 1)
                end.uniq
                res = []
                months.each do |month|
                    month_name = month.strftime('%Y-%m')
                    value = Booking.select do |booking| 
                        booking.created_at >= month && booking.created_at <= month.end_of_month
                    end

                    days = 0
                    value.each do |booking|
                        days += (booking.ends_on - booking.starts_on).to_i
                    end
                    
                    ans = {month: month_name, value: days}
                    res << ans
                end
                render json: res
            end
        end
    end
end