module V1
  class BookedDaysController < ActionController::API
    def index

      # returns list of all months in current year till now

      months = (Date.parse("2021-01-01")..Date.current).to_a.group_by { |date_str| date_str.month }.keys

      result = months.map { |month| { "month": Date.current.year.to_s + sprintf("-%02d", month) } }

      # create hash with structure:
      # [
      #   {"month": "2021-01", "values": 0 by default}
      # ]

      # each with a total number of days that were booked in given month
      # as json

      render json: result.as_json

    end
  end
end