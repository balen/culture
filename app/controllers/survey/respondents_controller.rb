require 'securerandom'

class Survey::RespondentsController < ResourceController
  SERIALIZER_CLASS = 'Survey::RespondentSerializer'.freeze
  POLICY_CLASS = 'Survey::RespondentPolicy'.freeze
  POLICY_SCOPE_CLASS = 'Survey::RespondentPolicy::Scope'.freeze

  skip_before_action :authenticate_user!, only: [:create, :show]
  skip_before_action :load_resource, only: [:create, :show]
  after_action :set_respondent, only: [:show, :create]
  def set_respondent
    set_current_respondent_id(respondent_id: @respondent.id) if @respondent&.id
  end

  def show
    p = permitted_params()
    @respondent = Survey::Respondent.find_by(respondent_id: p[:id])
    @respondent = Survey::Respondent.new() unless @respondent

    render_object(@respondent, includes: false)
  end

  def create
    # create an unique respondent code
    respondent_id = SecureRandom.alphanumeric(8)
    @respondent = Survey::Respondent.create(
      respondent_id: respondent_id
    )

    render_object(@respondent, includes: false)
  end

  def allowed_params
    %i[
      id
      lock_version
    ]
  end

end