FactoryBot.define do
  factory :survey_submission, class: 'Survey::Submission' do
    name { "test submission" }
    survey
    organization_survey { 
      association(
        :organization_survey,
        survey: survey,
        organization: association(:organization)
      )
    }
  end
end

# https://thoughtbot.github.io/factory_bot/cookbook/interconnected-associations.html
# https://semaphoreci.com/community/tutorials/working-effectively-with-data-factories-using-factorygirl