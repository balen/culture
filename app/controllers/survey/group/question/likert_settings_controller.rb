class Survey::Group::Question::LikertSettingsController < ResourceController
  MODEL_CLASS = 'Survey::LikertSetting'.freeze
  SERIALIZER_CLASS = 'Survey::LikertSettingSerializer'.freeze
  POLICY_CLASS = 'Survey::Group::Question::LikertSettingPolicy'.freeze
  POLICY_SCOPE_CLASS = 'Survey::Group::Question::LikertSettingPolicy::Scope'.freeze

  def belongs_to_param_id
    params[:question_id]
  end

  def belong_to_class
    Survey::Question
  end

  def belongs_to_relationship
    'likert_setting'
  end

  def allowed_params
    %i[
      lock_version
      id
      question
      question_id
    ]
  end
end
