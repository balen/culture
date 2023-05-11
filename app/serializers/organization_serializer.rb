class OrganizationSerializer
  include JSONAPI::Serializer

  attributes :id, :lock_version, :created_at, :updated_at,
             :name

  has_many :organization_surveys,
           serializer: OrganizationSurveySerializer,
           links: {
             self: -> (object, params) {
               "#{params[:domain]}/organization/#{object.id}"
             },
             related: -> (object, params) {
               "#{params[:domain]}/organization/#{object.id}/organization_surveys"
             }
           }
end
