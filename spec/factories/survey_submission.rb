FactoryBot.define do
  factory :survey_submission, class: 'Survey::Submission' do
    name { "test submission" }
    survey
    survey_respondent
    organization_survey { 
      association(
        :organization_survey,
        survey: survey,
        organization: association(:organization)
      )
    }
  end
end
