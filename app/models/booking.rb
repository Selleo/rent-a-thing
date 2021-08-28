class Booking < ApplicationRecord
  belongs_to :customer
  has_many :booked_items, dependent: :destroy
  has_many :items, through: :booked_items

  accepts_nested_attributes_for :booked_items, allow_destroy: true

  validates :starts_on, :ends_on, presence: true
  validates_associated :booked_items

  scope :created_in_month, -> (given_month) {
    where("created_at > :beginning_of_month and created_at < :end_of_month",
    beginning_of_month: Date.parse(given_month + "-01").beginning_of_month,
    end_of_month: Date.parse(given_month + "-01").end_of_month)
  }

  before_create do
    self.uuid = SecureRandom.uuid
  end

end
