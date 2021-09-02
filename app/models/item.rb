class Item < ApplicationRecord
  has_many :booked_items
  has_many :bookings, through: :booked_items, dependent: :destroy
  has_many_attached :photos
  belongs_to :category

  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
end
