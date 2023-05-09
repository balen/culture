class SurveySerializer
  include JSONAPI::Serializer

  attributes :id, :lock_version, :created_at, :updated_at, :name

  has_many :groups,
          serializer: Survey::GroupSerializer,
          links: {
            self: -> (object, params) {
              "#{params[:domain]}/survey/#{object.id}"
            },
            related: -> (object, params) {
              "#{params[:domain]}/survey/#{object.id}/groups"
            }
          }

  # has_many :submissions,
  #          # serializer: Survey::SubmissionSerializer,
  #          lazy_load_data: true,
  #          links: {
  #            self: -> (object, params) {
  #              "#{params[:domain]}/survey/#{object.id}"
  #            },
  #            related: -> (object, params) {
  #              "#{params[:domain]}/survey/#{object.id}/submissions"
  #            }
  #          }

end