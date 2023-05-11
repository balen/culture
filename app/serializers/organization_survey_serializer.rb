class OrganizationSurveySerializer
  include JSONAPI::Serializer

  attributes :id, :lock_version, :access_code

  attribute :number_submissions do |organization_survey|
    organization_survey.submissions.count
  end

  has_one :organization, lazy_load_data: true,
          lazy_load_data: true,
          if: Proc.new { |record| record.organization },
          links: {
            self: -> (object, params) {
              "#{params[:domain]}/organization_survey/#{object.id}"
            },
            related: -> (object, params) {
              "#{params[:domain]}/organization/#{object.organization_id}"
            }
          }

  has_one :survey, #lazy_load_data: true,
          if: Proc.new { |record| record.survey },
          links: {
            self: -> (object, params) {
              "#{params[:domain]}/organization_survey/#{object.id}"
            },
            related: -> (object, params) {
              "#{params[:domain]}/survey/#{object.survey_id}"
            }
          }

  has_many :submissions,
           # serializer: Survey::SubmissionSerializer,
           lazy_load_data: true,
           links: {
             self: -> (object, params) {
               "#{params[:domain]}/survey/#{object.id}"
             },
             related: -> (object, params) {
               "#{params[:domain]}/organization_survey/#{object.id}/submissions"
             }
           }
end