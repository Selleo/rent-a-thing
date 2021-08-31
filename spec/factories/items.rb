FactoryBot.define do
  factory :item do
    sequence(:name) { |i| "Bike ##{i}" }
    description { "Sample Description" }
    archived { false }
    category
  end
end
