class Booking < ApplicationRecord
  belongs_to :customer
  has_many :booked_items, dependent: :destroy
  has_many :items, through: :booked_items

  validates :customer_id, :starts_on, :ends_on, presence: true

  accepts_nested_attributes_for :booked_items, allow_destroy: true
end
