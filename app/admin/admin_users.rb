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
    end
    f.actions
  end

  show do
    panel "Admin" do
      attributes_table do
        row :email
        row :remember_created_at
      end
    end
    active_admin_comments
  end

end
