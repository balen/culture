# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include JSONAPI::Errors

  before_action :set_locale

  # skip_before_action :verify_authenticity_token
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action do
    cookies['XSRF-TOKEN'] = form_authenticity_token #unless cookies['XSRF-TOKEN']
  end

  def json_request?
    request.format.json?
  end

  def set_locale
    def_locale = :en #http_accept_language.compatible_language_from(I18n.available_locales)

    if session[:locale]
      def_locale = session[:locale]
    else
      def_locale = I18n.default_locale
    end

    I18n.locale = params[:locale].present? ? params[:locale] : def_locale

    session[:locale] = I18n.locale
  end

  def get_current_respondent_id
    Rails.logger.debug "********** RES ID IS #{session[:respondent_id]}"
    session[:respondent_id]
  end

  def set_current_respondent_id(respondent_id:)
    session[:respondent_id] = respondent_id
  end

  def current_respondent
    current_respondent_id = get_current_respondent_id
    return nil if current_respondent_id.nil?

    Survey::Respondent.find_by(id: current_respondent_id)
  end

  # before_action :authenticate_user!
  # skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?

  def prevent_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def pundit_user
    current_user
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized(e)
    # should be 403, need a redirect ????
    error = { status: '403', title: e.message }
    # render jsonapi_errors: [error], status: :unauthorized
    render json: [error], adapter: :json, status: :unauthorized, content_type: 'application/json'
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def record_not_found(e)
    error = { status: '404', title: e.message }
    # render jsonapi_errors: [error], status: :not_found
    render json: [error], adapter: :json, status: :not_found, content_type: 'application/json'
  end

  rescue_from ActiveRecord::ActiveRecordError, with: :processing_error
  rescue_from RuntimeError, with: :processing_error
  rescue_from ActiveRecord::RecordInvalid, with: :processing_error
  def processing_error(e)
    Rails.logger.error e.message if Rails.env.development?
    Rails.logger.error e.backtrace.join("\n\t") if Rails.env.development?

    error = { status: '422', title: e.message, detail: e.full_message, source: e.cause }
    # error = { status: '422', title: e.message, detail: e.cause, source: e.cause }
    # render jsonapi_errors: [error], status: :unprocessable_entity
    render json: [error], adapter: :json, status: :unprocessable_entity, content_type: 'application/json'
  end

  # def authenticate_user!
  #   user_signed_in?
  # end

  protected

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me email_addresses_attributes]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs

    devise_parameter_sanitizer.permit(:sign_in) do |user|
      user.permit(
        :username,
        :password,
        :remember_me,
        email_addresses_attributes: [:email]
      )
    end
  end

  def render_jsonapi_internal_server_error(exception)
    # Rails.logger.error "**** INTERNAL ERROR #{exception.class}"
    Rails.logger.error exception.message #if Rails.env.development?
    Rails.logger.error exception.backtrace.join("\n\t") #if Rails.env.development?
    # NOTE: if we have a central log put it in here
    super(exception)
  end

end
