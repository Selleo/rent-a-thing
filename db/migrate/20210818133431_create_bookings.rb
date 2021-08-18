class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.date :starts_on
      t.date :ends_on
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
