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
        #BookingMailer.with(booking: @booking).customer_confirmation.deliver_now
          @admin_emails = AdminUser.all.pluck(:email)

          # @booking = params[:booking]
           
        
      #byebug
            BookingMailer.with(emails: @admin_emails, booking: @booking ).admin_confirmation.deliver_now
        
        
      end
    end
  end


  # controller do
  #   def create
  #     create! do |_format|
  #       BookingMailer.with(booking: @booking).admin_confirmation.deliver_now
  #     end
  #   end
  # end



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
