class Customer < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, length: { maximum: 64 }
  validates :full_name, length: { minimum: 4, maximum: 64 }
  validates :phone, numericality: { allow_blank: true }
end
