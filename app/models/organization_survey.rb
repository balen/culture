# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class OrganizationSurvey < ApplicationRecord
  validates :access_code, uniqueness: true

  belongs_to :survey
  belongs_to :organization

  # TODO: scope to the access code and organization id
  has_many :submissions, class_name: 'Survey::Submission'
end
