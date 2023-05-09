class Organization::OrganizationSurveysController < ResourceController
  MODEL_CLASS = 'OrganizationSurvey'.freeze
  SERIALIZER_CLASS = 'OrganizationSurveySerializer'.freeze
  POLICY_CLASS = 'OrganizationSurveyPolicy'.freeze
  POLICY_SCOPE_CLASS = 'OrganizationSurveyPolicy::Scope'.freeze
  # DEFAULT_SORTBY = 'sort_order'

  def serializer_includes
    [
    ]
  end

  def includes
    [
    ]
  end

  def belongs_to_param_id
    params[:organization_id]
  end

  def belong_to_class
    Organization
  end

  def belongs_to_relationship
    'organization_surveys'
  end

  def allowed_params
    %i[
      lock_version
      survey_id
      organization_id
      id
    ]
  end

  # def after_save
  #   @object.update(sort_order_position: _permitted_params(model: object_name)['sort_order_position']) if _permitted_params(model: object_name)['sort_order_position'].present?
  # end
end
