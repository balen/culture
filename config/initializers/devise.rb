# frozen_string_literal: true

Devise.setup do |config|
  # The secret key used by Devise. Devise uses this key to generate
  # random tokens. Changing this key will render invalid all existing
  # confirmation, reset password and unlock tokens in the database.
  # Devise will use the `secret_key_base` as its `secret_key`
  # by default. You can change it below and use your own secret key.
  # config.secret_key = '76880452276652c3026e225a35e0d0f824db47cb7289b1a88245d328e256e5687d7c6b939ee5fc9f631399aaf981d50d1a12726b114b606956d0dcd523bd9ac8'

  # ==> Controller configuration
  # Configure the parent class to the devise controllers.
  # config.parent_controller = 'DeviseController'
  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 12

  # Send a notification to the original email when the user's email is changed.
  # config.send_email_changed_notification = false
  # Send a notification email when the user's password is changed.
  # config.send_password_change_notification = false

  config.reconfirmable = true

  # The time the user will be remembered without asking for credentials again.
  # config.remember_for = 2.weeks

  # Invalidates all the remember me tokens when the user signs out.
  config.expire_all_remember_me_on_sign_out = true

  # ==> Configuration for :validatable
  # Range for password length.
  config.password_length = 6..128

  # Email regex used to validate email formats. It simply asserts that
  # one (and only one) @ exists in the given string. This is mainly
  # to give user feedback and not to assert the e-mail validity.
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 12.hours

  # The default HTTP method used to sign out a resource. Default is :delete.
  config.sign_out_via = :delete
end
