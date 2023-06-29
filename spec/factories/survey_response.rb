FactoryBot.define do
  factory :survey_response, class: 'Survey::Response' do    
    submission {association( :survey_submission)}
    question {association( :survey_question)}
  end
end
