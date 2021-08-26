class Customer < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :bookings, dependent: :destroy
end
