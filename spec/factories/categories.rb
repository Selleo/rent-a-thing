FactoryBot.define do
  factory :category do
    sequence(:name) { |i| "Category ##{i}" }
    description { "Sample Description" }
  end
end
