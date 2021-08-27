class CreateBookedItems < ActiveRecord::Migration[6.1]
  def change
    create_table :booked_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
