class Customer < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :full_name, presence: true, length: { maximum: 55 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, length: { maximum: 55 }
  validates :phone, numericality: true, presence: true, length: { maximum: 55 }

end
