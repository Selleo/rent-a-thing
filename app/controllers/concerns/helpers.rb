module Helpers
  def generate_months(starting_date, ending_date = Date.current)
    dates = []
    current_date = starting_date.beginning_of_month

    while current_date <= ending_date.beginning_of_month
      dates << current_date
      current_date += 1.month
    end

    dates
  end

  def chart_result(name, value)
    {
      data: {
        attributes: {
          name: name,
          value: value
        }
      }
    }
  end
end