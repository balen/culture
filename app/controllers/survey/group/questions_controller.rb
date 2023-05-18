class Survey::Group::QuestionsController < ResourceController
  MODEL_CLASS = 'Survey::Question'.freeze
  SERIALIZER_CLASS = 'Survey::QuestionSerializer'.freeze
  POLICY_CLASS = 'Survey::Group::QuestionPolicy'.freeze
  POLICY_SCOPE_CLASS = 'Survey::Group::QuestionPolicy::Scope'.freeze

  def includes
    [
      :answers,
      { likert_setting: :likert_categories }
    ]
  end

  def belongs_to_param_id
    params[:group_id]
  end

  def belong_to_class
    Survey::Group
  end

  def belongs_to_relationship
    'questions'
  end

  def allowed_params
    %i[
      lock_version
      id
      title
      question
      question_type
      lock_version
      mandatory
      text_size
      horizontal
      private
      regex
      group
      group_id
      answers_attributes
      linked_field
    ]
  end

  # def object_destroy_method
  #   :soft_delete
  # end
end
