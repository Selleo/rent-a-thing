FactoryBot.define do
  factory :booking do
    starts_on { "2021-08-18" }
    ends_on { "2021-08-18" }
    customer { nil }
  end
end
