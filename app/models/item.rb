class Item < ApplicationRecord
  has_many :booked_items
  has_many :bookings, through: :booked_items, dependent: :destroy
  belongs_to :category

  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }

  validates :name, presence: true
  validates :price_per_day, numericality: { greater_than_or_equal_to: 0.0 }
end
