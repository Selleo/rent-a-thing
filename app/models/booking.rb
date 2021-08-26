class Booking < ApplicationRecord
  belongs_to :customer
  has_many :booked_items, dependent: :destroy
  has_many :items, through: :booked_items

  validates :starts_on, presence:true
  validates :ends_on, presence:true
  validates :booked_items, presence:true
  validates :customer, presence:true



  accepts_nested_attributes_for :booked_items, allow_destroy: true
end
