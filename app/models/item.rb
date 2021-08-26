class Item < ApplicationRecord
  has_many :booked_items
  has_many :bookings, through: :booked_items, dependent: :destroy
  belongs_to :category

  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
  validates :name, presence: true
  validates :description, presence: true
  validates :price_per_day,  presence: true
end
