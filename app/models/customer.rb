class Customer < ApplicationRecord
  has_many :bookings, dependent: :destroy
  validates :full_name, presence: true
  validates :phone, presence: true, numericality: true
  validates :email, presence: true,
            format: { with: /^(.+)@(.+)$/, message: "Email invalid", :multiline => true },
            uniqueness: { case_sensitive: false },
            length: { minimum: 4, maximum: 254 }

end
