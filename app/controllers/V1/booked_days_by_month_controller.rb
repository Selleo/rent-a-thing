 module V1
    class BookedDaysByMonthController < ActionController::API
      def show
        bookings_length_by_month = Booking.
          where(created_at: Date.current.all_year).
          group_by{ |booking| booking.created_at.month }.
          transform_values do |bookings|
            bookings.sum do |booking|
              (booking.ends_on - booking.starts_on).to_i
            end
        end
  
        result = (1..Date.current.month).map do |month|
          {
            'month' => Date.new(Date.current.year, month).strftime("%Y-%m"),
            'value' => bookings_length_by_month[month] || 0
          }
        end
  
        render json: result
      end
    end
  end


  #module V1
 #   class BookedDaysByMonthController < ActionController::API
  #    def index
   #     # returns a list of all months up till (and including) current one in current year...
    #      bookings = Booking.all.order(:created_at)
          #bookings.group_by(months)
      #    bookings_by_month = bookings.group_by { |b| b.created_at.strftime"%Y,%m")}
     #    count_in_month = bookings_by_month.count()


      #render json: bookings_by_month.as_json(only: [:created_at, :count_in_month])
      #end
    #end
  #end