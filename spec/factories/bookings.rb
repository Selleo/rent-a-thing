FactoryBot.define do
  factory :booking do
    starts_on { Date.current + 3.days }
    ends_on { starts_on + 1.week }
    customer
    items { [create(:item)] }

    trait :not_confirmed do
      confirmed_at { nil }
    end
  end
end
