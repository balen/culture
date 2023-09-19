class Survey::SubmissionSerializer
  include JSONAPI::Serializer

  attributes :id, :lock_version, :survey_id,
             :organization_survey_id, :submission_state, :survey_respondent_id,
             :created_at, :updated_at

  has_many :responses,
            serializer: Survey::ResponseSerializer,
            # lazy_load_data: true,
            links: {
              self: -> (object, params) {
                "#{params[:domain]}/submission/#{object.id}"
              },
              related: -> (object, params) {
                "#{params[:domain]}/submission/#{object.id}/responses"
              }
            }
end
