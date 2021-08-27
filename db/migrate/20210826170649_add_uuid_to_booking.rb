class AddUuidToBooking < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :uuid, :uuid
  end
end
