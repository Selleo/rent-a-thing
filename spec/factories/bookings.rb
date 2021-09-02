FactoryBot.define do
  factory :booking do
    starts_on { Date.current + 3.days }
    ends_on { starts_on + 1.week }
    customer
    items { [create(:item)] }
<<<<<<< HEAD
=======

    trait :not_confirmed do
      confirmed_at { nil }
    end
>>>>>>> aadcb3c766d512b0f3d592c80c5381c25a08f4eb
  end
end
