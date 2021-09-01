require 'rails_helper'

RSpec.describe '/v1/bookings/:id/confirm' do
  describe 'POST /v1/bookings/:id/confirm' do
    fit 'sets confirmed_at to current time for given booking' do
      booking = create(:booking, :not_confirmed)

      travel_to DateTime.new(2020, 1, 1, 12) do
        expect do
          post "/v1/bookings/#{booking.id}/confirm"
        end.to change { booking.reload.confirmed_at }.from(nil).to(DateTime.new(2020, 1, 1, 12))
      end
    end
  end
end
