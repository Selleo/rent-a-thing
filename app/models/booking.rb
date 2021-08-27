class Booking < ApplicationRecord
  belongs_to :customer
  has_many :booked_items, dependent: :destroy
  has_many :items, through: :booked_items

  accepts_nested_attributes_for :booked_items, allow_destroy: true

  scope :active, -> { where(archived_at: nil).where("ends_on > :ends_on", ends_on: Time.current) }
end
