class Item < ApplicationRecord
  has_many :booked_items
  has_many :bookings, through: :booked_items, dependent: :destroy
  belongs_to :category

    validates :price, numericality: true, presence: true, length: { maximum: 10 }
    validates :description, presence: true, length: { maximum: 600 }
    validates :name, presence: true, length: { maximum: 55 }


  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
end
