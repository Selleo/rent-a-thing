class AddArchivedAtToBookingModel < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :archived_at, :datetime, default: nil
  end
end
