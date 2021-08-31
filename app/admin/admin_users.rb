ActiveAdmin.register AdminUser do
  menu label: 'Users', parent: 'Administration'

  permit_params :email, :password, :password_confirmation, :mail_notifications

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :mail_notifications
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do
    panel 'Admin User Details' do
      attributes_table_for admin_user do
        row :email
        row :reset_password_token
        row :reset_password_sent_at
        row :remember_created_at
        row :mail_notifications
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :mail_notifications
    end
    f.actions
  end
end
