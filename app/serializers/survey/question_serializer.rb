class Survey::QuestionSerializer
  include JSONAPI::Serializer

  attributes :id, :question, :question_type,
             :created_at, :updated_at, :lock_version,
             :group_id

  has_one :likert_setting, serializer: Survey::LikertSettingSerializer,
            if: Proc.new { |record| record.likert_setting },
            links: {
              self: -> (object, params) {
                "#{params[:domain]}/question/#{object.id}"
              },
              related: -> (object, params) {
                "#{params[:domain]}/likert_setting/#{object.likert_setting.id}"
              }
            }
end
