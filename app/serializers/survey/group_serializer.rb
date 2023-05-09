class Survey::GroupSerializer
  include JSONAPI::Serializer

  attributes :id, :name,
             :created_at, :updated_at, :survey_id


  # has_many :questions, serializer: Survey::QuestionSerializer,
  #           links: {
  #             self: -> (object, params) {
  #               "#{params[:domain]}/page/#{object.id}"
  #             },
  #             related: -> (object, params) {
  #               "#{params[:domain]}/page/#{object.id}/questions"
  #             }
  #           }
end
