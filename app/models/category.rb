class Category < ApplicationRecord
  has_many :items

  validates :description, presence: true, length: { maximum: 600 }
  validates :name, presence: true, length: { maximum: 55 }
end
