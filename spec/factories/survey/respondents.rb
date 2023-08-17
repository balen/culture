require 'securerandom'
FactoryBot.define do
  factory :survey_respondent, class: 'Survey::Respondent' do
    respondent_id { SecureRandom.alphanumeric(8) }
  end
end
