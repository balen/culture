# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class OrganizationSurvey::SubmissionsController < ResourceController
  SERIALIZER_CLASS = 'Survey::SubmissionSerializer'.freeze
  MODEL_CLASS = 'Survey::Submission'.freeze
  POLICY_CLASS = 'Survey::SubmissionPolicy'.freeze
  POLICY_SCOPE_CLASS = 'Survey::SubmissionPolicy::Scope'.freeze
  # TODO: where is this?
  # XLS_SERIALIZER_CLASS = 'Survey::SubmissionXlsSerializer'.freeze
  DEFAULT_SORTBY = 'survey_submissions.updated_at'
  
  def can_access_question?(question, person)
    if question.private
      AccessControlService.allowed_sensitive_access?(person: person)
    elsif question.linked_field
      AccessControlService.linked_field_access?(linked_field: question.linked_field, person: person)
    else
      true
    end
  end

  def can_access_response?(response, person)
    # if it is my response then I can have access
    return true if response.submission&.person_id == person.id

    if response.question.private
      AccessControlService.allowed_sensitive_access?(person: person)
    elsif response.question.linked_field
      AccessControlService.linked_field_access?(linked_field: response.question.linked_field, person: person)
    else
      true
    end
  end

  def belong_to_class
    return OrganizationSurvey if params[:organization_survey_id].present?
  end

  def belongs_to_relationship
    'submissions'
  end

  def belongs_to_param_id
    params[:organization_survey_id]
  end

  def before_save
    # Make sure the submission is assigned to the current person
    # if there is one ... and survey is not unassigned
    # @object.person_id = current_person.id if current_person
  end

  # After save and if state changes to submitted we may need
  # to transistion the person's state?
  def after_save
    process_responses
  end

  def after_update
    process_responses
  end

  def process_responses
    p = params.require(:data).permit!
    responses = p[:attributes][:responses_attributes]

    if (responses)
      responses.each do |res|
        r = Survey::Response.exists? res[:id]
        if r
          r.update(res)
        else
          Survey::Response.create(res)
        end
      end
    end
  end

  def index
    format = params[:format]

    # If XLS then we do somethng else
    if (format == 'xls') || (format == 'xlsx')
      send_data collection_to_xls,
        filename: "submissions_#{Time.now.strftime('%m-%d-%Y')}.xlsx",
        disposition: 'attachment'
    else
      super
    end
  end

  # faster collection to Excel
  def collection_to_xls
    workbook = FastExcel.open(constant_memory: true) # creates tmp file
    worksheet = workbook.add_worksheet("Export")
    date_time_style = workbook.number_format("d mmm yyyy h:mm")
    styles = [date_time_style,date_time_style]
    # Get the survey questions
    submission = @collection.first

    organization_survey = OrganizationSurvey.find params[:organization_survey_id] if params[:organization_survey_id]
    survey = organization_survey.survey
    survey ||= submission.survey
    header = ['Created At', 'Updated At']
    response_columns = {}
    posn = 2
    survey.questions.each do |question|
      next if [:hr, :textonly].include? question.question_type

      header << question.question

      response_columns[question.id] = posn
      posn += 1
    end
    worksheet.append_row(header)

    @collection.each do |submission|
      row = [submission.created_at, submission.updated_at]
      row.concat Array.new(response_columns.size)
      submission.responses.each do |response|
        if response_columns[response.question_id]
          row[response_columns[response.question_id]] = response.response_as_text
        end
      end
      worksheet.append_row(
        row,
        styles
      )
    end
    workbook.read_string
  end

  def collection_actions
    [:index, :flat]
  end

  def serializer_includes
    [
      :responses
    ]
  end

  def includes
    [
      :organization_survey
    ]
  end

  def references
    [
      :organization_survey
    ]
  end

  def join_tables
    [
      :responses
    ]
  end

  def delete_all
    OrganizationSurvey.transaction do
      org_survey = OrganizationSurvey.find_by(id: params[:organization_survey_id])
      authorize org_survey, policy_class: policy_class

      org_survey.submissions.destroy_all

      render status: :ok, json: {}.to_json, content_type: 'application/json'
    end
  end

  # 
  def allowed_params
    %i[
      id
      lock_version
      organization_survey_id
      responses
      organization_survey
      survey_id
      survey
      submission_state
    ]
  end
end
