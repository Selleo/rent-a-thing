class Customer < ApplicationRecord
  has_many :bookings, dependent: :destroy

  scope :created_in_month, -> (given_month) {
    where("created_at >= :beginning_of_month and created_at <= :end_of_month",
          beginning_of_month: Date.parse(given_month + "-01").beginning_of_month,
          end_of_month: Date.parse(given_month + "-01").end_of_month)
  }

  scope :customers_in_month, -> (given_month) {
    where("created_at >= :start and created_at <= :end",
          start: Date.parse("2020-01-01"),
          end: Date.parse(given_month + "-01").end_of_month)
  }
end
