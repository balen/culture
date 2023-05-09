class CreateSurveyQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_questions, id: :uuid do |t|
      t.jsonb :question, default: {}
      t.string :question_type, default: 'textfield'

      t.uuid :group_id, null: false

      t.datetime :deleted_at
      t.integer :lock_version
      t.timestamps
    end
    add_foreign_key :survey_questions, :survey_groups, column: :group_id
  end
end
