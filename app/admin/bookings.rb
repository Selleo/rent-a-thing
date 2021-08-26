ActiveAdmin.register Booking do
  menu priority: 2

  index do
    id_column
    column :customer
    column :starts_on do |booking|
      I18n.l(booking.starts_on, format: :long)
    end
    column :ends_on do |booking|
      I18n.l(booking.ends_on, format: :long)
    end
    actions
  end


  filter :customer
  filter :created_at

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
