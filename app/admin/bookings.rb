ActiveAdmin.register Booking do
  menu priority: 2

  # ==============
  # ==== LIST ====
  # ==============

  filter :customer
  filter :created_at

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :customer_id, :starts_on, :ends_on, booked_items_attributes: %i[id item_id _destroy]

  index do
    selectable_column
    column :id
    column :starts_on
    column :ends_on
    column :customer
    column :booked_items
    actions
  end

  show do
    panel "Booking Details" do
      attributes_table_for booking do
        row :starts_on
        row :ends_on
        row :customer
      end
    end
  end

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
