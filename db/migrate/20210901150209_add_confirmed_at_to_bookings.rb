class AddConfirmedAtToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :confirmed_at, :datetime
  end
end
