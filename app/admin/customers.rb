ActiveAdmin.register Customer do
  menu priority: 3

  index do
    selectable_column
    id_column
    column :full_name
    column :email
    column :phone
    actions
  end

  # ==============
  # ==== LIST ====
  # ==============

  filter :full_name

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :full_name, :email, :phone
end
