# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class UsersController < ResourceController
  SERIALIZER_CLASS = 'UserSerializer'.freeze
  POLICY_CLASS = 'UserPolicy'.freeze
  POLICY_SCOPE_CLASS = 'UserPolicy::Scope'.freeze

  # need to add includes etc to speed up query
  skip_before_action :load_resource, only: [:me]

  # no before action
  def me
    me = current_user
    authorize me, policy_class: policy_class

    render_object(me,
      serializer: UserSessionSerializer,
      # jsonapi_included: [
      #   :email_addresses
      # ]
    )
  end

  def allowed_params
    %i[
      id
      lock_version
      name
      email
      user
    ]
  end
end
