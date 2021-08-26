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
    selectable_column
    id_column
    column :full_name
    column :email
    column :phone
    actions
  end

  show do
    columns do
      column do
        attributes_table do
          row :id
          row :full_name
          row :email
          row :phone
          row :created_at
          row :updated_at
        end

        active_admin_comments
      end

      column do
        panel 'Bookings' do
          table_for resource.bookings do
            column :starts_on
            column :ends_on
            column :items
          end
        end
      end
    end
  end
  
end
