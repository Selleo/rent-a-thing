class AddPricePerDayToItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :price_per_day, :float
  end
end
