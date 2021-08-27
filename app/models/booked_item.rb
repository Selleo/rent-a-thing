class BookedItem < ApplicationRecord
  belongs_to :item
  belongs_to :booking
end
