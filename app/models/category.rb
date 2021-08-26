class Category < ApplicationRecord
  has_many :items

  validates :name, presence: true, length: { maximum: 32, minimum: 2 }
end
