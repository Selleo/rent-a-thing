ActiveAdmin.register Customer do
  menu priority: 3

  # ==============
  # ==== LIST ====
  # ==============

  filter :full_name
  filter :email
  filter :phone

  index do
    selectable_column
    id_column

    column :full_name
    column :email
    column :phone
    column("Bookings", &:bookings)

    actions
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :full_name, :email, :phone
end
