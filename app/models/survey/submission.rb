# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class Survey::Submission < ApplicationRecord
  belongs_to :survey
  belongs_to :organization_survey

  has_many :responses,
           class_name: 'Survey::Response',
           foreign_key: 'submission_id',
           inverse_of: :submission,
           dependent: :destroy

  enum submission_state: { draft: 'draft', submitted: 'submitted' }

  belongs_to :survey_respondent, class_name: 'Survey::Respondent'

  # TODO: list the "asked questions" so we can use these to deprioritze on subsequent surveys
end
