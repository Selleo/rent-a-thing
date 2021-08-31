class Booking < ApplicationRecord
  belongs_to :customer
  has_many :booked_items, dependent: :destroy
  has_many :items, through: :booked_items

  validates :customer_id, :starts_on, :ends_on, presence: true

  scope :not_archived, -> { where(archived_at: nil, ends_on: DateTime.current..DateTime::Infinity.new) }
  scope :in_month, ->(month) { where(starts_on: month.all_month) }
  scope :first_to_start, -> { order(:starts_on).first }

  def booked_days
    1 if ends_on == starts_on

    (ends_on - starts_on).to_i
  end

  accepts_nested_attributes_for :booked_items, allow_destroy: true
end
