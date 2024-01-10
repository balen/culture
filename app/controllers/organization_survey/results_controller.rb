# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true

  #
  # Controller responsible for providing the various results
  #
  class OrganizationSurvey::ResultsController < ApplicationController
    before_action :authenticate_user!, except: %i[my_results my_count]

    def index
      os = OrganizationSurvey.find params[:organization_survey_id]

      results = {
        ps: results_for(group_short_code: :PS, org_survey: os),
        tm: results_for(group_short_code: :TM, org_survey: os),
        gm: results_for(group_short_code: :GM, org_survey: os)
      }

      render json: results, adapter: :json, content_type: 'application/json'
    end

    def my_count
      survey_respondent_id = get_current_respondent_id
      raise 'no current respondent' if survey_respondent_id.nil?

      org_survey = OrganizationSurvey.find_by(access_code: params[:organization_survey_id])

      answered_question_count = View::ResponseView.select(:question_id).distinct.where(
        'access_code = ? and survey_respondent_id = ?', org_survey.access_code, survey_respondent_id
      ).count

      results = { count: answered_question_count }

      render json: results, adapter: :json, content_type: 'application/json'
    end

    # TODO: return only the result with the lowest range
    def my_results
      sr_id = get_current_respondent_id
      raise 'no current respondent' if sr_id.nil?

      os = OrganizationSurvey.find_by(access_code: params[:organization_survey_id])

      ps = results_for(group_short_code: :PS, org_survey: os, survey_respondent_id: sr_id)
      tm = results_for(group_short_code: :TM, org_survey: os, survey_respondent_id: sr_id)
      gm = results_for(group_short_code: :GM, org_survey: os, survey_respondent_id: sr_id)
      p2t = results_for(group_short_code: :P2T, org_survey: os, survey_respondent_id: sr_id)
      ptw = results_for(group_short_code: :PTW, org_survey: os, survey_respondent_id: sr_id)
      cb = results_for(group_short_code: :CB, org_survey: os, survey_respondent_id: sr_id)

      result = [ps, tm, gm, p2t, ptw, cb].min_by { |e| e[:range][:width] }

      render json: result, adapter: :json, content_type: 'application/json'
    end

    def results_for(group_short_code:, org_survey:, survey_respondent_id: nil)
      calc = ScoreCalculator.new
      group = Survey::Group.find_by short_code: group_short_code

      results = calc.individual_scores(
        organization_id: org_survey.organization_id,
        access_code: org_survey.access_code,
        group_short_code: group_short_code,
        survey_respondent_id: survey_respondent_id
      )

      range = calc.range(group_short_code: group_short_code, scores: results)

      return {
        title: group&.name,
        short_code: group_short_code,
        questions: ScoreCalculator::WEIGHTS[group_short_code].map{|k,v| k},
        total: calc.total(scores: results),
        scores: results,
        range: range,
        summary: View::ResponseView.summary(
          organization_id: org_survey.organization_id,
          access_code: org_survey.access_code,
          group_short_code: group_short_code,
          survey_respondent_id: survey_respondent_id
        )
      }
    end
  end
