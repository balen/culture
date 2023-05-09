#
class OrganizationsController < ResourceController
  SERIALIZER_CLASS = 'OrganizationSerializer'.freeze
  POLICY_CLASS = 'OrganizationPolicy'.freeze
  POLICY_SCOPE_CLASS = 'OrganizationPolicy::Scope'.freeze
  DEFAULT_SORTBY = 'name'.freeze
  DEFAULT_ORDER = 'desc'.freeze

  def serializer_includes
    [
      # :organization_surveys
    ]
  end

  def includes
    [
      :organization_surveys
    ]
  end

  def allowed_params
    %i[
      id
      lock_version
      name
      organization_surveys
      organization_surveys_attributes
    ]
  end
end