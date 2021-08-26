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

  show do
    columns do
      column do
        attributes_table do
          row :full_name
          row :email
          row :phone
        end

        active_admin_comments
      end

      column do
        panel "Bookings" do
          table_for customer.bookings do
            column("Booking") { |booking| booking }
            column("Items") { |booking| booking.booked_items.map { |booked_item| booked_item.item.name } }
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
