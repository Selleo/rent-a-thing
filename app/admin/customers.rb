ActiveAdmin.register Customer do
  menu priority: 3

  # ==============
  # ==== LIST ====
  # ==============

  filter :full_name

  index do
    selectable_column
    id_column
    column :full_name
    column :email
    column :phone
    column :priority
    actions
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :full_name, :email, :phone
end
