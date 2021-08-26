class AddUuidFieldToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :uuid, :uuid, default: "gen_random_uuid()"
  end
end
