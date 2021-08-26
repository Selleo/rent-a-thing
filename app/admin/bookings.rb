ActiveAdmin.register Booking do
  menu priority: 2

  # ==============
  # ==== LIST ====
  # ==============

  filter :customer
  filter :created_at

  index do
    selectable_column
    id_column

    column :customer
    column :starts_on
    column :ends_on
    column("Items") { |booking| booking.booked_items.map { |booked_item| booked_item.item.name } }

    actions
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
