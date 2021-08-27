class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :archived, default: false

      t.timestamps
    end
  end
end
