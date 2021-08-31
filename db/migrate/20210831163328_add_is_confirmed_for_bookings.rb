class AddIsConfirmedForBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :is_confirmed, :boolean, default: false, null: false
  end
end
