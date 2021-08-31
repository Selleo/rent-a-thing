ActiveAdmin.register AdminUser do
  menu label: 'Users', parent: 'Administration'
  config.comments = false
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column

    column :email
    column :created_at

    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :disabled_notifications
    end
    f.actions
  end

end
