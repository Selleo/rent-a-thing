class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end

    add_belongs_to :items, :category

    add_index :categories, :name, unique: true
  end
end
