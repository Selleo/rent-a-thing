FactoryBot.define do
  factory :booking do
    starts_on { Date.current + 3.days }
    ends_on { starts_on + 1.week }
    customer
    items { [create(:item)] }
  end
end
