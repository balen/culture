# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class Users::PasswordsController < Devise::PasswordsController
  respond_to :json

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    redirect_to "/#/login/password-reset?reset_password_token=#{params[:reset_password_token]}"
  end
end
