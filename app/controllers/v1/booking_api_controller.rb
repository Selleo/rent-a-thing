class V1::BookingApiController < ApplicationController
  def booked_days_by_month_original
    # grab and parse ?year param from URI
    # check if year is valid and it isn't the same as current year (as to not set months to 12 for current year)
    if params[:year].present? && params[:year].to_i != Date.current.year
      # throw errors if input is invalid
      return throw_parameter_missing_error unless /(19|20)\d{2}/.match(params[:year])
      return throw_no_future_dates_error if params[:year].to_i > Date.current.year

      # otherwise set the filtering to that year as a whole
      date_to_filter_by = Date.new(params[:year].to_i, 12)
    elsif date_to_filter_by = Date.current
      # we're dealing with current year so doing that is fine as it will contain the month data
    end
    # group all bookings by month in hash { [month_index]: Booking[] }
    bookings_at_specified_year = Booking.where(starts_on: date_to_filter_by.all_year).all.group_by do |b|
      b.starts_on.month
    end
    # month is going from 1 to current month (April - 4) or from 1 - 12 if older year was specified
    output = (1..date_to_filter_by.month).map do |month|
      bookings = bookings_at_specified_year[month]
      days_diff = bookings ? bookings.sum { |b| (b.ends_on - b.starts_on).to_i } : 0
      { "month": Date.new(date_to_filter_by.year, month).strftime('%Y-%m'), "value": days_diff }
    end
    render json: {
      name: ''
    }
  end

  def items_by_earnings
    output = Item.all.map do |item|
      sum = item.bookings.sum do |booking|
        item.price * booking.booked_days
      end.to_f
      { "category": item.name, "value": sum } unless sum.zero?
    end.compact

    render json: {
      data: {
        attributes: {
          name: 'Items by Earnings',
          value: output
        }
      }
    }
  end

  def new_customers_by_month
    output = Customer
             .all
             .sort_by { |c| c.created_at }
             .group_by { |c| c.created_at.strftime('%b %Y') }
             .map do |_key, _customers|
      customers = []
      _customers.each do |c|
        customers.push(c.full_name)
      end
      customers_count = customers.uniq.count
      { 'category' => _key, 'value' => customers_count } if customers_count > 0
    end
    render json: {
      data: {
        attributes: {
          name: 'New Customers by Month',
          value: output
        }
      }
    }
  end

  def booked_days_by_month
    bookings_length_by_month = Booking
                               .where(created_at: Date.current.all_year)
                               .group_by { |booking| booking.created_at.month }
                               .transform_values do |bookings|
      bookings.sum do |booking|
        (booking.ends_on - booking.starts_on).to_i
      end
    end

    result = (1..Date.current.month).map do |month|
      {
        'category' => Date.new(Date.current.year, month).strftime('%Y-%m'),
        'value' => bookings_length_by_month[month] || 0
      }
    end

    render json: {
      data: {
        attributes: {
          name: 'Booked days by month',
          value: result
        }
      }
    }
  end

  def bookings_by_item
    output = Item.all.select { |i| i.bookings.count > 0 }.map do |item|
      { "category": item.name, "value": item.bookings.count }
    end
    render json: {
      data: {
        attributes: {
          name: 'Bookings by Items',
          value: output
        }
      }
    }
  end

  private

  def throw_parameter_missing_error
    render json: { error: 'Invalid Year Parameter' }, status: 400
  end

  def throw_no_future_dates_error
    render json: { error: 'No Future Dates' }, status: 400
  end
end
