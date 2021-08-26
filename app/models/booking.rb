require 'securerandom'
class Booking < ApplicationRecord
  belongs_to :customer
  has_many :booked_items, dependent: :destroy
  has_many :items, through: :booked_items

  accepts_nested_attributes_for :booked_items, allow_destroy: true

  validates :starts_on, :ends_on, presence: true
  # validates :items, presence: true
  # validates_presence_of :items
  validates_associated :booked_items

  before_create do
    self.uuid=SecureRandom.uuid
  end

end
