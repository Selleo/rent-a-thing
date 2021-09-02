module V1
    class BookingsController < ActionController::API
      
     def index
        all_bookings = Booking.all
        render json: all_bookings.as_json(only: [:id, :name, :description])
      end
    
   
    def create  
       
        booking = Booking.new(customer_id: params[:customer_id], starts_on: params[:starts_on], ends_on: params[:ends_on], customer_id:  customer.id,  items: Item.find(params[:item_ids]))
        
        booking.save!
        head 201
    end
    



end

  end
  