require 'rails_helper'

RSpec.describe '/v1/bookings' do
  describe 'POST /v1/bookings' do
    it 'creates a booking for given item, customer and time span' do
      item = create(:item)

      travel_to(Date.new(2021, 6, 1)) do
        expect {
          post '/v1/bookings', params: {
            customer_name: 'Tony Halik',
            customer_phone: '+48509111111',
            starts_on: '2021-10-01',
            ends_on: '2021-10-02',
            item_ids: [item.id]
          }
        }.to change { Booking.count }.by(1)

        expect(response).to be_created
        booking = Booking.last
        expect(booking).to have_attributes(starts_on: Date.new(2021,10,1), ends_on: Date.new(2021, 10, 2))
        expect(booking.items).to contain_exactly(item)
        expect(booking.customer).to have_attributes(full_name: 'Tony Halik', phone: '+48509111111')
      end
    end

    it 'returns booking summary in the response' do
      item = create(:item, name: 'Fantom 24X')

      travel_to(Date.new(2021, 6, 1)) do
        post '/v1/bookings', params: {
          customer_name: 'Tony Halik',
          customer_phone: '+48509111111',
          starts_on: '2021-10-01',
          ends_on: '2021-10-02',
          item_ids: [item.id]
        }

        booking = Booking.last
        expect(response.body).to be_present
        json_response = JSON.parse(response.body)
        expect(json_response).to match(
                                   'booking_id' => booking.id,
                                   'customer_name' => 'Tony Halik',
                                   'customer_phone' => '+48509111111',
                                   'starts_on' => '2021-10-01',
                                   'ends_on' => '2021-10-02',
                                   'booked_items' => 'Fantom 24X'
                                 )
      end
    end

    context 'when provided with multiple item ids' do
      it 'books all of the items' do
        item = create(:item, name: 'Fantom 24X')
        another_item = create(:item, name: 'Dust-diver F1000')

        travel_to(Date.new(2021, 6, 1)) do
          post '/v1/bookings', params: {
            customer_name: 'Tony Halik',
            customer_phone: '+48509111111',
            starts_on: '2021-10-01',
            ends_on: '2021-10-02',
            item_ids: [item.id, another_item.id]
          }

          booking = Booking.last
          expect(booking.items).to contain_exactly(item, another_item)
          json_response = JSON.parse(response.body)
          expect(json_response).to include('booked_items' => 'Fantom 24X, Dust-diver F1000')
        end
      end
    end

    context 'when any of given items was already booked in requested time frame' do
      it 'responds with 409 Conflict' do
        item = create(:item, name: 'Fantom 24X')
        another_item = create(:item, name: 'Dust-diver F1000')
        create(
          :booking,
          items: [another_item],
          starts_on: Date.new(2021, 10, 3),
          ends_on: Date.new(2021, 10, 4)
        )

        travel_to(Date.new(2021, 6, 1)) do
          expect {
            post '/v1/bookings', params: {
              customer_name: 'Tony Halik',
              customer_phone: '+48509111111',
              starts_on: '2021-10-01',
              ends_on: '2021-10-05',
              item_ids: [item.id, another_item.id]
            }
          }.to_not change { Booking.count }

          expect(response.status).to eq 409
        end
      end
    end

    context 'when no items were specified' do
      it 'responds with 400 Bad Request' do
        travel_to(Date.new(2021, 6, 1)) do
          post '/v1/bookings', params: {
            customer_name: 'Tony Halik',
            customer_phone: '+48509111111',
            starts_on: '2021-10-01',
            ends_on: '2021-10-05',
            item_ids: []
          }

          expect(response).to be_bad_request
        end
      end
    end


    context 'when booking start time is in the past' do
      it 'responds with 400 Bad Request' do
        item = create(:item)

        travel_to(Date.new(2021, 6, 1)) do
          post '/v1/bookings', params: {
            customer_name: 'Tony Halik',
            customer_phone: '+48509111111',
            starts_on: '2021-05-30',
            ends_on: '2021-06-05',
            item_ids: [item.id]
          }

          expect(response).to be_bad_request
        end
      end
    end

    context 'when booking start time is later than end time' do
      it 'responds with 400 Bad Request' do
        item = create(:item)

        travel_to(Date.new(2021, 6, 1)) do
          post '/v1/bookings', params: {
            customer_name: 'Tony Halik',
            customer_phone: '+48509111111',
            starts_on: '2021-06-15',
            ends_on: '2021-06-12',
            item_ids: [item.id]
          }

          expect(response).to be_bad_request
        end
      end
    end

    context 'when customer has not provided full name' do
      it 'responds with 400 Bad Request' do
        item = create(:item)

        travel_to(Date.new(2021, 6, 1)) do
          post '/v1/bookings', params: {
            customer_name: '',
            customer_phone: '+48509111111',
            starts_on: '2021-06-15',
            ends_on: '2021-06-18',
            item_ids: [item.id]
          }

          expect(response).to be_bad_request
        end
      end
    end

    context 'when customer has not provided phone number' do
      it 'responds with 400 Bad Request' do
        item = create(:item)

        travel_to(Date.new(2021, 6, 1)) do
          post '/v1/bookings', params: {
            customer_name: 'Tony Halik',
            customer_phone: '',
            starts_on: '2021-06-15',
            ends_on: '2021-06-18',
            item_ids: [item.id]
          }

          expect(response).to be_bad_request
        end
      end
    end

    context 'when customer exists' do
      it 'create booking with existing customer' do
        customer = create(:customer, full_name: "John Smith", phone: "+48123456789", email: "john@smith.com")
        item = create(:item, name: "Rower")

        travel_to(Date.new(2021, 6, 1)) do
          expect {
            post '/v1/bookings', params: {
              customer_name: "John Smith",
              customer_phone: "+48123456789",
              customer_email: "john@smith.com",
              starts_on: '2021-06-15',
              ends_on: '2021-06-18',
              item_ids: [item.id]
            }
          }.to change {
            customer.bookings.count
          }.from(0).to(1)
        end
      end
    end
  end
end
