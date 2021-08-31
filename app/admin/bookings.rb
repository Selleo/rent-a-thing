ActiveAdmin.register Booking do
  menu priority: 2

  # ==============
  # ==== LIST ====
  # ==============

  filter :customer
  filter :created_at

  controller do
    def create
      create! do |_format|
        BookingMailer.with(booking: @booking).customer_confirmation.deliver_now
        AdminUser.all.each do |user|
          BookingMailer.with(admin_user: user, booking: @booking).mail_admins.deliver_now
        end
      end
    end
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :customer_id, :starts_on, :ends_on, booked_items_attributes: %i[id item_id _destroy]

  index do
    selectable_column
    column :id
    column :starts_on   # i tutaj  zmienic format daty ???
    column :ends_on
    column :customer
    column :booked_items
    actions
  end

  show do
    panel 'Booking Details' do
      attributes_table_for booking do
        row :starts_on
        row :ends_on
        row :customer
        row 'Archive' do
          link_to 'Archive This Booking', booking_path(booking), method: :delete
        end
      end
    end
  end

  form do |_f|
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
