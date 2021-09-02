class Booking < ApplicationRecord
  belongs_to :customer
  has_many :booked_items, dependent: :destroy
  has_many :items, through: :booked_items

  accepts_nested_attributes_for :booked_items, allow_destroy: true

  validate :does_not_overlap_other_bookings

  private

  def does_not_overlap_other_bookings
    return if items.none? do |item|
      item.bookings.any? do |other_booking|
        dates.overlaps?(other_booking.dates)
      end
    end

    errors.add(:starts_on, 'Overlaps with other booking')
    errors.add(:ends_on, 'Overlaps with other booking')
  end

  protected

  def dates
    (starts_on..ends_on)
  end
end
