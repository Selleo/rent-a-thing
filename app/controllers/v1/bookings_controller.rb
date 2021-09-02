module V1
    class BookingsController < ActionController::API
      
     def index
        all_bookings = Booking.all
        render json: all_bookings.as_json(only: [:id, :name, :description])
      end
    
   
    def create  
        customer= Customer.new(full_name: params[:customer_name], phone: params[:customer_phone]  ) 
        customer.save!
       # customerid = Customer.last.id
        booking = Booking.new(starts_on: params[:starts_on], ends_on: params[:ends_on], customer_id:  customer.id,  items: Item.find(params[:item_ids]))
        
        booking.save!
        head 201
    end
    



end

  end
  