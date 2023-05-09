# Copyright (c) 2023 Henry Balen. All Rights Reserved.
class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :lock_version, :created_at, :updated_at,
             :name, :email
end
