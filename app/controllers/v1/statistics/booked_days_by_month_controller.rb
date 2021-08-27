class V1::Statistics::BookedDaysByMonthController < ApplicationController
  def index
    # grab and parse ?year param from URI
    # check if year is valid and it isn't the same as current year (as to not set months to 12 for current year)
    if params[:year].present? && params[:year].to_i != Date.current.year
      # throw errors if input is invalid
      return throw_parameter_missing_error if !/(19|20)\d{2}/.match(params[:year])
      return throw_no_future_dates_error if params[:year].to_i > Date.current.year
      # otherwise set the filtering to that year as a whole
      date_to_filter_by = Date.new(params[:year].to_i, 12)
    elsif
      # we're dealing with current year so doing that is fine as it will contain the month data
      date_to_filter_by = Date.current
    end
    # group all bookings by month in hash { [month_index]: Booking[] }
    bookings_at_specified_year = Booking.where(starts_on: date_to_filter_by.all_year).all.group_by{ |b| b.starts_on.month }
    # month is going from 1 to current month (April - 4) or from 1 - 12 if older year was specified
    output = (1..date_to_filter_by.month).map do | month |
      bookings = bookings_at_specified_year[month]
      days_diff = bookings ? bookings.sum { |b| (b.ends_on - b.starts_on).to_i } : 0
      { "month": Date.new(date_to_filter_by.year, month).strftime("%Y-%m"), "value": days_diff }
    end
    render json: output
  end


  private  
  def throw_parameter_missing_error
    return render json: { error: "Invalid Year Parameter" }, status: 400
  end

  def throw_no_future_dates_error
    return render json: { error: "No Future Dates" }, status: 400
  end
end
