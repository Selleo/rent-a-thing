class AddArchivedAtToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :archived_at, :datetime
  end
end