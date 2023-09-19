# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class OrganizationSurvey::ResultsController < ApplicationController
  before_action :authenticate_user!, except: [:my_results]

  def index
    calc = ScoreCalculator.new
    org_survey = OrganizationSurvey.find params[:organization_survey_id]

    ps_results = calc.psychological_safety(organization_id: org_survey.organization_id, access_code: org_survey.access_code)
    tm_results =  calc.total_motivation(organization_id: org_survey.organization_id, access_code: org_survey.access_code)
    gm_results =  calc.growth_mindset(organization_id: org_survey.organization_id, access_code: org_survey.access_code)

    results = {
      ps: {
        questions: ScoreCalculator::WEIGHTS[:PS].map{|k,v| k},
        total: calc.total(scores: ps_results),
        scores: ps_results,
        summary: View::ResponseView.summary(organization_id: org_survey.organization_id, access_code: org_survey.access_code, group_short_code: :PS)
      },
      tm: {
        questions: ScoreCalculator::WEIGHTS[:TM].map{|k,v| k},
        total: calc.total(scores: tm_results),
        scores: tm_results,
        summary: View::ResponseView.summary(organization_id: org_survey.organization_id, access_code: org_survey.access_code, group_short_code: :TM)
      },
      gm: {
        questions: ScoreCalculator::WEIGHTS[:GM].map{|k,v| k},
        total: calc.total(scores: gm_results),
        scores: gm_results,
        summary: View::ResponseView.summary(organization_id: org_survey.organization_id, access_code: org_survey.access_code, group_short_code: :GM)
      }
    }

    render json: results,
        adapter: :json,
        content_type: 'application/json'
  end

  def my_results
    survey_respondent_id = get_current_respondent_id
    raise "no current respondent" if survey_respondent_id.nil?

    calc = ScoreCalculator.new
    # org_survey = OrganizationSurvey.find(params[:organization_survey_id])
    org_survey = OrganizationSurvey.find_by(access_code: params[:organization_survey_id])

    ps_results = calc.psychological_safety(organization_id: org_survey.organization_id, access_code: org_survey.access_code, survey_respondent_id: survey_respondent_id)
    tm_results =  calc.total_motivation(organization_id: org_survey.organization_id, access_code: org_survey.access_code, survey_respondent_id: survey_respondent_id)
    gm_results =  calc.growth_mindset(organization_id: org_survey.organization_id, access_code: org_survey.access_code, survey_respondent_id: survey_respondent_id)

    results = {
      ps: {
        questions: ScoreCalculator::WEIGHTS[:PS].map{|k,v| k},
        total: calc.total(scores: ps_results),
        scores: ps_results,
        summary: View::ResponseView.summary(organization_id: org_survey.organization_id, access_code: org_survey.access_code, group_short_code: :PS, survey_respondent_id: survey_respondent_id)
      },
      tm: {
        questions: ScoreCalculator::WEIGHTS[:TM].map{|k,v| k},
        total: calc.total(scores: tm_results),
        scores: tm_results,
        summary: View::ResponseView.summary(organization_id: org_survey.organization_id, access_code: org_survey.access_code, group_short_code: :TM, survey_respondent_id: survey_respondent_id)
      },
      gm: {
        questions: ScoreCalculator::WEIGHTS[:GM].map{|k,v| k},
        total: calc.total(scores: gm_results),
        scores: gm_results,
        summary: View::ResponseView.summary(organization_id: org_survey.organization_id, access_code: org_survey.access_code, group_short_code: :GM, survey_respondent_id: survey_respondent_id)
      }
    }

    render json: results,
        adapter: :json,
        content_type: 'application/json'
  end
end
