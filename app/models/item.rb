class Item < ApplicationRecord
  has_many :booked_items
  has_many :bookings, through: :booked_items, dependent: :destroy
  belongs_to :category

  has_many :item_pictures, dependent: :destroy
  has_many :booking_exceptions, dependent: :destroy

  validates :name, presence: true, length: { minimum: 4, maximum: 64 }
  validates :price_per_day, presence: true, numericality: true

  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }

  scope :not_booked, ->(starts, ends) do
    def overlaps?(objects, range)
      objects.map do |object|
        (object.starts_on..object.ends_on).overlaps?(range)
      end.none?
    end

    Item.all.filter_map do |item|
      range = starts..ends
      item if overlaps?(item.bookings, range) && overlaps?(item.booking_exceptions, range)
    end
  end

  accepts_nested_attributes_for :item_pictures, allow_destroy: true

end
