ActiveAdmin.register Booking do
  menu priority: 2

  index do
    selectable_column
    id_column
    column :starts_on
    column :ends_on
    column :customer
    column :created_at
    column :archived_at
    column :confirmed
    column :by_admin
    actions defaults: false do |booking|
      item "View", admin_booking_path(booking)
      item "Edit", edit_admin_booking_path(booking) if !booking.by_admin
      item "Delete", admin_booking_path(booking),:method => :delete
    end
  end

  # ==============
  # ==== LIST ====
  # ==============

  filter :customer
  filter :created_at

  controller do
    def create
      create! do |_format|
        unless @booking.by_admin
          BookingMailer.with(booking: @booking).send_booking_confirmation.deliver_now
          AdminUser.all.each do |admin|
            BookingMailer.with(booking: @booking, admin_user:admin).inform_admin.deliver_now if !admin.disabled_notifications
          end
        end
      end
    end

    def destroy
      destroy! do |_format|
        BookingMailer.with(booking: @booking).inform_about_cancelation.deliver_now unless @booking.by_admin
      end
    end

    def update
      if Booking.find(params[:id]).by_admin
        redirect_to collection_path, notice: "You cannot update booking exception. Remove it and create a new one"
      else
        update!
      end
    end

  end



  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :customer_id, :starts_on, :ends_on, :by_admin, booked_items_attributes: %i[id item_id _destroy]

  form do |f|
    inputs do
      input :customer
      input :starts_on
      input :ends_on
      input :by_admin
    end

    has_many(:booked_items, new_record: 'Add item', heading: 'Booked items', allow_destroy: true) do |b|
      b.input :item
    end

    actions
  end
end
