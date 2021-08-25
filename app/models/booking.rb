class Booking < ApplicationRecord
  belongs_to :customer
  has_many :booked_items, dependent: :destroy
  has_many :items, through: :booked_items

  accepts_nested_attributes_for :booked_items, allow_destroy: true
  validates :starts_on, :ends_on, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if ends_on.blank? || starts_on.blank?

    if ends_on <= starts_on
      errors.add(:end_date, "must be after the start date")
    end

  end
end
