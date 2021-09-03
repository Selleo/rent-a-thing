module V1
  class AvailableItemsController < ActionController::API
    def index
      starts_on = Date.parse(params.fetch(:start_date))
      ends_on = Date.parse(params.fetch(:end_date))

      available_items = Item.not_booked(starts_on, ends_on)

      render json: available_items.as_json(only: [:id, :name, :description])
    end
  end
end
