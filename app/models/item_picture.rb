class ItemPicture < ApplicationRecord
  has_one_attached :image

  def create
    create! do
      image.attach(params[:image])
    end
  end

  belongs_to :item
end
