class Category < ApplicationRecord
  has_many :items
  has_many_attached :fotos
end
