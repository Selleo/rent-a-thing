class Item < ApplicationRecord
  has_many :booked_items
  has_many :bookings, through: :booked_items, dependent: :destroy
  belongs_to :category

  validates :name, presence: true, length: { minimum: 4, maximum: 64 }
  validates :price_per_day, presence: true, numericality: true

  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
end
