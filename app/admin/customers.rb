ActiveAdmin.register Customer do
  menu priority: 3
  config.comments = false
  # ==============
  # ==== LIST ====
  # ==============
  index do
    selectable_column
    column :id
    column :full_name
    column :email
    column :phone

    actions
  end


  filter :full_name

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :full_name, :email, :phone



end
