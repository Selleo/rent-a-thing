class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :archived, default: false
      t.float :price_per_day, default: 1.00

      t.timestamps
    end
  end
end
