class Survey::AnswerSerializer
  include JSONAPI::Serializer

  attributes :id, :answer, :created_at,
             :updated_at, :lock_version, :question_id
end
