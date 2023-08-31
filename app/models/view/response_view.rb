class View::ResponseView < ApplicationRecord
  self.table_name = :responses_view
  self.primary_key = :response_id

  def readonly?
    true
  end

  def self.summary(organization_id:, access_code:, group_short_code: nil, survey_respondent_id: nil)
    q = where(organization_id: organization_id, access_code: access_code)
    q = q.where(group_short_code: group_short_code) if group_short_code
    q = q.where(survey_respondent_id: survey_respondent_id) if survey_respondent_id

    if group_short_code
      q.group(:short_code).count
    else
      q.group(:group_short_code, :short_code).count
    end
  end

  def self.responses(organization_id:, access_code: nil, group_short_code: nil, survey_respondent_id: nil)
    q = where(organization_id: organization_id)
    q = q.where(access_code: access_code) if access_code
    q = q.where(group_short_code: group_short_code) if group_short_code
    q = q.where(survey_respondent_id: survey_respondent_id) if survey_respondent_id

    q.order(:access_code, :submission_id, :group_short_code, :short_code).group_by{|r| r.submission_id}
  end
end
