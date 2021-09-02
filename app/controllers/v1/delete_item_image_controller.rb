class V1::DeleteItemImageController < ApplicationController
  def delete
    item = Item.find(params[:item_id])
    attachment = item.item_images.find(params[:attachment_id])
    attachment.destroy

    redirect_back(fallback_location: '/')
  end
end
