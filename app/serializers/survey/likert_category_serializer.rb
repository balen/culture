class Survey::LikertCategorySerializer
  include JSONAPI::Serializer

  attributes :id, :label, :value, :order,
             :created_at, :updated_at, :lock_version,
             :likert_setting_id
end
