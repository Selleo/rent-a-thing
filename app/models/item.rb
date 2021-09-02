class Item < ApplicationRecord
  has_many :booked_items
  has_many :bookings, through: :booked_items, dependent: :destroy
  belongs_to :category
  has_many_attached :item_images

  # validates :price, presence: true, numericality: true

  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
end
