class Survey::Group::Question::AnswersController < ResourceController
  MODEL_CLASS = 'Survey::Answer'.freeze
  SERIALIZER_CLASS = 'Survey::AnswerSerializer'.freeze
  POLICY_CLASS = 'Survey::Group::Question::AnswerPolicy'.freeze
  POLICY_SCOPE_CLASS = 'Survey::Group::Question::AnswerPolicy::Scope'.freeze

  def belongs_to_param_id
    params[:question_id]
  end

  def belong_to_class
    Survey::Question
  end

  def belongs_to_relationship
    'answers'
  end

  def allowed_params
    %i[
      lock_version
      id
      answer
      lock_version
      default
      other
      question
      question_id
    ]
  end
end
