class CreateSurveyGroupsSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_groups_surveys, id: false do |t|
      t.uuid :group_id #, class_name: "Survey::Group", foreign_key: "group_id"
      t.uuid :survey_id #, class_name: "Survey", foreign_key: "survey_id"
    end

    add_foreign_key :survey_groups_surveys, :survey_groups, column: :group_id
    add_foreign_key :survey_groups_surveys, :surveys, column: :survey_id

    # survey_groups
    # t.uuid :survey_id, null: false
    # change_column_default :survey_groups, :survey_id, nil
    change_column_null :survey_groups, :survey_id, true
  end
end
