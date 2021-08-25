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
  # ==== SHOW ====
  # ==============

  show do
    columns do
      column do
        attributes_table do
          row :full_name
          row :email
          row :phone
        end
      end

      column do
        panel 'Bookings' do
          table_for resource.bookings do
            column :id do |booking|
              @id = booking.id
              render partial: 'id_link', locals: {id: booking.id}
            end
            column :starts_on
            column :ends_on
          end
        end
      end
    end
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :full_name, :email, :phone
end
