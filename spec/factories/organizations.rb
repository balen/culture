FactoryBot.define do
  factory :organization do
    sequence(:name) { |n| "Test organization #{n}" }
  end
end
