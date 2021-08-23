ActiveAdmin.register Booking do
  menu priority: 2

  # ==============
  # ==== LIST ====
  # ==============

  filter :customer
  filter :created_at

  # ==============
  # ==== SHOW ====
  # ==============

  show do
    columns do
      column do
        attributes_table do
          row :starts_on
          row :ends_on
        end
      end

      column do
        attributes_table do
          row :customer
        end

        active_admin_comments
      end
    end

    columns do
      column do
        panel 'Items' do
          header_action link_to('All items', [:admin, :items])

          table_for booking.booked_items do |booked_item|
            column :item
            column :description do |booked_item|
              booked_item.item.description
            end
          end
        end
      end
    end
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :customer_id, :starts_on, :ends_on, booked_items_attributes: %i[id item_id _destroy]

  form do |f|
    inputs do
      input :customer
      input :starts_on
      input :ends_on
    end

    has_many(:booked_items, new_record: 'Add item', heading: 'Booked items', allow_destroy: true) do |b|
      b.input :item
    end

    actions
  end
end
