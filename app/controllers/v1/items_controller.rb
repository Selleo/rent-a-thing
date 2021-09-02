module V1
  class ItemsController < ActionController::API
    def index
      render json: Item.all
    end

    def show
      render json: Item.find(params[:id]), include: :photos
    end

    def delete_item_image
      image = Item.find(params[:id]).photos.find(params[:image_id])
      image.destroy
      redirect_back fallback_location: '/'
    end
  end
end