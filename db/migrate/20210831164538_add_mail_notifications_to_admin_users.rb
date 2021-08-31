class AddMailNotificationsToAdminUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :admin_users, :mail_notifications, :boolean
  end
end
