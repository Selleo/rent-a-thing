class Customer < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :email, presence: true, length: { minimum: 4, maximum: 64 }
  validates :full_name, length: { minimum: 4, maximum: 64 }
  validates :phone, presence: true
end
