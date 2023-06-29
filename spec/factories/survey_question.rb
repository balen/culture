FactoryBot.define do
  factory :survey_question, class: 'Survey::Question' do
    sequence(:question) { |n| "test question #{n}" }

    group {association :survey_group }
  end
end