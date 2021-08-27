module V1
  class BookedDaysController < ActionController::API
    def index

      # returns list of all months in current year

      months = Date.current.year.months
      # each with a total number of days that were booked in given month
      # as json

      render json: months.as_json


    end
  end
end