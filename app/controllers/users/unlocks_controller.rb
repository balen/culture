# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
#
# Changed to only use JSON and JWT tokens
#
class Users::UnlocksController < Devise::UnlocksController
  respond_to :json

  private
    def respond_with(resource, _opts = {})
      redirect_to "/#/login"
    end
end
