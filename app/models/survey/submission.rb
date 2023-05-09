class Survey::Submission < ApplicationRecord
  belongs_to :survey
  belongs_to :organization_survey

  has_many :responses,
           class_name: 'Survey::Response',
           foreign_key: 'submission_id',
           inverse_of: :submission,
           dependent: :destroy

  enum submission_state: { draft: 'draft', submitted: 'submitted' }
end
