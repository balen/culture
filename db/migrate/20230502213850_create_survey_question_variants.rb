class CreateSurveyQuestionVariants < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_question_variants, id: :uuid do |t|
      t.jsonb :question, default: {}

      t.uuid :question_id, null: false

      t.integer :lock_version
      t.timestamps
    end
    add_foreign_key :survey_question_variants, :survey_questions, column: :question_id
  end
end
