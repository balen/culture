# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class OrganizationSurvey < ApplicationRecord
  validates :access_code, uniqueness: true

  belongs_to :survey
  belongs_to :organization

  # TODO: scope to the access code and organization id
  has_many :submissions, class_name: 'Survey::Submission'

  # Enum to say whether the survey will be segmented geographically
  # via the postal code. Default is none (i.e not geographically segmented)
  enum use_postal_code: {none: 'none', usa: 'usa', canada: 'canada', uk: 'uk', rotw: 'rotw'}, _scopes: false
end
