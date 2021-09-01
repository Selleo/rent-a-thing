class Add < ActiveRecord::Migration[6.1]
  def change
    add_column :admin_users, :is_getting_notifications, :boolean
  end
end
