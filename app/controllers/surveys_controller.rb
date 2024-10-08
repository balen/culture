# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class SurveysController < ResourceController
  SERIALIZER_CLASS = 'SurveySerializer'.freeze
  POLICY_CLASS = 'SurveyPolicy'.freeze
  POLICY_SCOPE_CLASS = 'SurveyPolicy::Scope'.freeze
  DEFAULT_SORTBY = 'surveys.updated_at'.freeze
  DEFAULT_ORDER = 'desc'.freeze

  skip_before_action :authenticate_user!, only: [:start, :find]

  # To start a survey
  def start
    # verify the access code
    org = OrganizationSurvey.find_by access_code: params[:access_code]
    raise "No such Organization" unless org
    svc = SurveyService.getService(survey: org.survey)

    # if we have access code and a current respondent
    #  then we know what questions they have been asked and
    #  use that to weight the "random" questions ....
    questions = if Rails.env.test?
                  svc.deterministicQuestions(respondent: current_respondent)
                else
                  svc.randomQuestions(respondent: current_respondent)
                end

    options = {
        include: [
          :'likert_setting',
          :'likert_setting.likert_categories'
        ],
        params: {
          domain: "#{request.base_url}"
        }
      }
    render json: Survey::QuestionSerializer.new(questions, options).serializable_hash(),
      content_type: 'application/json'
  end

  # Find a survey by the access code
  def find
    org = OrganizationSurvey.find_by access_code: params[:access_code]
    raise "No such Organization" unless org

    survey = org.survey
    set_current_respondent_id(respondent_id: nil)
    reset_session

    render_object(survey)
  end

  def serializer_includes
    [
      :groups,
      :'groups.questions',
      :'groups.questions.likert_setting',
      :'groups.questions.likert_setting.likert_categories'
    ]
  end

  def includes
    [
      {
        groups: {
          questions: [
            {
              likert_setting: :likert_categories
            }
          ]
        }
      }
    ]
  end

  def references
    [
      :submissions
    ]
  end

  def allowed_params
    %i[
      id
      lock_version
      name
      name_en
      name_fr
      groups
      groups_attributes
    ]
  end
end
