# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
#
# Changed to only use JSON and JWT tokens
#
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def get_session
    return current_user
  end

  private
    def respond_with(resource, _opts = {})
      super unless resource.id

      if resource.id
        render json: {
          message: 'You are logged in.'
        }, status: :ok
      end
    end
end
