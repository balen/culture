class Survey::SubmissionSerializer
  include JSONAPI::Serializer

  attributes :id, :lock_version, :survey_id,
             :organization_survey_id, :submission_state,
             :created_at, :updated_at

  # has_many :responses,
  #           lazy_load_data: true,
  #           links: {
  #             self: -> (object, params) {
  #               "#{params[:domain]}/submission/#{object.id}"
  #             },
  #             related: -> (object, params) {
  #               "#{params[:domain]}/submission/#{object.id}/responses"
  #             }
  #           }
end
