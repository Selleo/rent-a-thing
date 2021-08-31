class AddConfirmedToBooking < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :confirmed, :boolean, default: false
  end
end
