class Customer < ApplicationRecord
  has_many :bookings, dependent: :destroy

  scope :first_created, -> { order(:created_at).first }
  scope :in_month, ->(month) { where(created_at: month.all_month) }

  validates :email, presence: true, length: { minimum: 4, maximum: 64 }
  validates :full_name, length: { minimum: 4, maximum: 64 }
  validates :phone, presence: true
end
