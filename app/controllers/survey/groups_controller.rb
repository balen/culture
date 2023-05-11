class Survey::GroupsController < ResourceController
  MODEL_CLASS = 'Survey::Group'.freeze
  SERIALIZER_CLASS = 'Survey::GroupSerializer'.freeze
  POLICY_CLASS = 'Survey::GroupPolicy'.freeze
  POLICY_SCOPE_CLASS = 'Survey::GroupPolicy::Scope'.freeze

  def serializer_includes
    [
      :questions,
      :'questions.answers'
    ]
  end

  def includes
    [
      {
        questions: :answers
      }
    ]
  end

  def belongs_to_param_id
    params[:survey_id]
  end

  def belong_to_class
    Survey
  end

  def belongs_to_relationship
    'groups'
  end

  def allowed_params
    %i[
      lock_version
      id
      title
      survey_id
      survey
      questions_attributes
    ]
  end
end
