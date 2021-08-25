class Customer < ApplicationRecord
  has_many :bookings, dependent: :destroy
  validates :full_name, :email, :phone, presence: true
end
