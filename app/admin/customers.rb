ActiveAdmin.register Customer do
  menu priority: 3

  # ==============
  # ==== LIST ====
  # ==============

  filter :full_name

  # ==============
  # ==== EDIT ====
  # ==============

  index do
      
      column :full_name
      column :email
      column :phone
      column :bookings
  end

      show do
        attributes_table do

          row :full_name
          row :email
          row :phone
          row :bookings
            end
    end
  permit_params :full_name, :email, :phone
end
