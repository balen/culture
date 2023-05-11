class Survey::LikertSettingSerializer
  include JSONAPI::Serializer

  attributes :id, :left_label, :right_label,
             :created_at, :updated_at, :lock_version,
             :question_id

  has_many :likert_categories, serializer: Survey::LikertCategorySerializer
            # links: {
            #   self: -> (object, params) {
            #     "#{params[:domain]}/page/#{object.id}"
            #   },
            #   related: -> (object, params) {
            #     "#{params[:domain]}/page/#{object.id}/questions"
            #   }
            # }
end
