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

  show do
    columns do
      column do
        attributes_table do
          row :customer
          row :starts_on
          row :ends_on
          row("Is Archived") { |booking| booking.archived_at != nil }
          row("Total price") { |booking|
            days = [1, (booking.ends_on - booking.starts_on).to_i].max
            price = 0
            booking.booked_items.each { |booked_item|
              price += booked_item.item.price_per_day * days
            }
            price
          }
        end

        active_admin_comments
      end

      column do
        panel "Items rented" do
          table_for booking.booked_items do
            column :item
            column("Description") { |booked_item| booked_item.item.description }
            column("Price per day") { |booked_item| booked_item.item.price_per_day }
          end
        end
      end
    end
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :customer_id, :starts_on, :ends_on, booked_items_attributes: %i[id item_id _destroy]

  controller do
    def create
      create! do |_format|
        BookingMailer.with(booking: @booking).customer_confirmation.deliver_now
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
