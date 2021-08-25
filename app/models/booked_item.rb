class BookedItem < ApplicationRecord
  belongs_to :item
  belongs_to :booking

  validates :item, presence: true
end
