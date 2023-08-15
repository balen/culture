# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class SurveysController < ResourceController
  SERIALIZER_CLASS = 'SurveySerializer'.freeze
  POLICY_CLASS = 'SurveyPolicy'.freeze
  POLICY_SCOPE_CLASS = 'SurveyPolicy::Scope'.freeze
  DEFAULT_SORTBY = 'surveys.updated_at'.freeze
  DEFAULT_ORDER = 'desc'.freeze

  skip_before_action :authenticate_user!, only: [:start]

  # To start a survey
  # Create a survey respondent with a access code
  # 

  def start
    # verify the access code
    org = OrganizationSurvey.find_by access_code: params[:access_code]
    raise "No such Organization" unless org
    svc = SurveyService.getService(survey: org.survey)

    questions = svc.randomQuestions

    options = {
        include: [
          :'answers',
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

  def take_survey
    org = OrganizationSurvey.find_by access_code: params[:access_code]
    svc = SurveyService.getService(survey: org.survey)
    # find or create the respondent based on the id passed in
    # if not found then create a new responent with a random id
    questions = svc.randomQuestions

    options = {
        include: [
          :'answers',
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

  def serializer_includes
    [
      :groups,
      :'groups.questions',
      :'groups.questions.answers',
      :'groups.questions.likert_setting',
      :'groups.questions.likert_setting.likert_categories'
    ]
  end

  def includes
    [
      {
        groups: {
          questions: [
            :answers,
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

  # def join_tables
  #   surveys = Arel::Table.new(Survey.table_name)
  #   updated_by = Arel::Table.new(Person.table_name).alias('updated_by')
  #   [
  #     surveys.create_join(
  #       updated_by,
  #       surveys.create_on(
  #         surveys[:updated_by_id].eq(updated_by[:id])
  #       ),
  #       Arel::Nodes::OuterJoin
  #     )
  #   ]
  # end

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
