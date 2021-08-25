class AddPricePerDayItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :price_per_day, :decimal, precicion: 2
  end
end
