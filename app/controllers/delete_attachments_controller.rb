class DeleteAttachmentsController < ApplicationController
  def index
    @items = Item.all.sort_by(&:created_at).reverse
  end

  def show
    @item = Item.find(params[:id])
    @item_attachments = @item.item_images
  end
end
