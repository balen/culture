FactoryBot.define do
  factory :organization_survey do
    sequence(:access_code) { |n| "test_code_#{n}" }
    survey
    organization
  end
end
