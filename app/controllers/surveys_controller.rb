class SurveysController < ResourceController
  SERIALIZER_CLASS = 'SurveySerializer'.freeze
  POLICY_CLASS = 'SurveyPolicy'.freeze
  POLICY_SCOPE_CLASS = 'SurveyPolicy::Scope'.freeze
  DEFAULT_SORTBY = 'surveys.updated_at'.freeze
  DEFAULT_ORDER = 'desc'.freeze

  def serializer_includes
    [
      :groups,
      :'groups.questions',
      :'groups.questions.answers',
      :'groups.questions.likert_setting',
      :'groups.questions.likert_setting.likert_categories'
    ]
  end

  def includes
    [
      {
        groups: {
          questions: [
            :answers,
            {
              likert_setting: :likert_categories
            }
          ]
        }
      }
    ]
  end

  def references
    [
      :submissions
    ]
  end

  # def join_tables
  #   surveys = Arel::Table.new(Survey.table_name)
  #   updated_by = Arel::Table.new(Person.table_name).alias('updated_by')
  #   [
  #     surveys.create_join(
  #       updated_by,
  #       surveys.create_on(
  #         surveys[:updated_by_id].eq(updated_by[:id])
  #       ),
  #       Arel::Nodes::OuterJoin
  #     )
  #   ]
  # end

  def allowed_params
    %i[
      id
      lock_version
      name
      name_en
      name_fr
      groups
      groups_attributes
    ]
  end
end
