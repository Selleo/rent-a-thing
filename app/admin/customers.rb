ActiveAdmin.register Customer do
  menu priority: 3

  index do
    id_column
    column :full_name
    column :phone
    column :email
    actions
  end

  filter :full_name

  show do
    attributes_table do
      row :full_name
      row :phone
      row :email
      row :customer_booking_count do |customer|
        customer.bookings.count
      end
    end

    panel "Customer Bookings" do
      table_for customer.bookings.active do
        column :starts_on
        column :ends_on
        column :booking_items do |booking|
          booking.items.pluck(:name)
        end
      end
    end
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :full_name, :email, :phone
end
