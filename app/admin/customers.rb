ActiveAdmin.register Customer do
  menu priority: 3

  # ==============
  # ==== LIST ====
  # ==============

  filter :full_name

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :full_name, :email, :phone
  index do
    id_column
    column  :full_name
    column  :email
    column  :phone
    column  :created_at

  end
end
