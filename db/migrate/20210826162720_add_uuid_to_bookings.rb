class AddUuidToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :uuid, :string
  end
end
