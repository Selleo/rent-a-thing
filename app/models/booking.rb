class Booking < ApplicationRecord
  belongs_to :customer
  has_many :booked_items
  has_many :items, through: :booked_items

  accepts_nested_attributes_for :booked_items, allow_destroy: true
end
