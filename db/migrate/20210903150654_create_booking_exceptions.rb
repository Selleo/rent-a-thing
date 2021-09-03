class CreateBookingExceptions < ActiveRecord::Migration[6.1]
  def change
    create_table :booking_exceptions do |t|
      t.references :item, null: false, foreign_key: true
      t.date :starts_on, null: false
      t.date :ends_on, null: false

      t.timestamps
    end
  end
end
