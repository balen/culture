FactoryBot.define do
  factory :survey_group, class: 'Survey::Group' do
    sequence(:name) { |n| "test_group_#{n}" }
    survey
  end
end