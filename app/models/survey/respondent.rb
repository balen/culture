class Survey::Respondent < ApplicationRecord
  # has a code
  validates_presence_of :respondent_id
  validates_uniqueness_of :respondent_id

  # has many submissions
  has_many :submissions,
           class_name: 'Survey::Submission',
           foreign_key: 'survey_respondent_id',
           inverse_of: :survey_respondent,
           dependent: :destroy
end
