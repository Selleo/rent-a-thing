class AddDisableEmailNotificationForAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admin_users, :disabled_notifications, :boolean, default: false, null: false
  end
end
