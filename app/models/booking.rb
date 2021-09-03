class Booking < ApplicationRecord
  belongs_to :customer, :required => false
  has_many :booked_items, dependent: :destroy
  has_many :items, through: :booked_items

  accepts_nested_attributes_for :booked_items, allow_destroy: true

  validate :overlap_detected?, on: :create

  def overlap_detected?
    overlap = items.any? do |item|
      item.bookings.any? do |booking|
        booking_dates = (booking.starts_on..booking.ends_on)
        query_dates = (starts_on..ends_on)
        booking_dates.overlaps?(query_dates)
      end
    end

    if overlap
      errors.add(:base, "Dates conflict")
    end
  end
end
