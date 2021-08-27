class Booking < ApplicationRecord
  belongs_to :customer
  has_many :booked_items, dependent: :destroy
  has_many :items, through: :booked_items

  validates :starts_on, presence:true
  validates :ends_on, presence:true
  validates :booked_items, presence:true
  validates :customer, presence:true


  def is_archived?
      if booking.archived_at != 0
      end
  end

  scope :active, -> { where(archived_at: nil).where("ends_on > :ends_on", ends_on: Time.current) }
  accepts_nested_attributes_for :booked_items, allow_destroy: true


end
