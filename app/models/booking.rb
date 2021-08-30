class Booking < ApplicationRecord
  # self.primary_key = :uuid
  belongs_to :customer
  has_many :booked_items, dependent: :destroy
  has_many :items, through: :booked_items

  # before_create do
  # self.uuid = SecureRandom.uuid
  # end

  scope :available, -> { where(archived_at: nil).where('ends_on > :date', date: Time.current) }

  accepts_nested_attributes_for :booked_items, allow_destroy: true

  def booked_days
    return 1 if ends_on == starts_on

    (ends_on - starts_on).to_i
  end
end
