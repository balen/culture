# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class Organization::OrganizationSurveysController < ResourceController
  MODEL_CLASS = 'OrganizationSurvey'.freeze
  SERIALIZER_CLASS = 'OrganizationSurveySerializer'.freeze
  POLICY_CLASS = 'OrganizationSurveyPolicy'.freeze
  POLICY_SCOPE_CLASS = 'OrganizationSurveyPolicy::Scope'.freeze

  def serializer_includes
    [
      :survey
    ]
  end

  def includes
    [
      :survey
    ]
  end

  def belongs_to_param_id
    params[:organization_id]
  end

  def belong_to_class
    Organization
  end

  def belongs_to_relationship
    'organization_surveys'
  end

  def allowed_params
    %i[
      lock_version
      survey_id
      organization_id
      id
      access_code
    ]
  end
end
