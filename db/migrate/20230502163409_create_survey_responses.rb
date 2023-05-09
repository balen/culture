class CreateSurveyResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_responses, id: :uuid do |t|
      t.uuid :submission_id, null: false
      t.uuid :question_id, null: false
      t.jsonb :response
      t.text :response_as_text

      t.integer :lock_version
      t.timestamps
    end
    add_index :survey_responses, [:submission_id, :question_id]
    add_foreign_key :survey_responses, :survey_submissions, column: :submission_id
    add_foreign_key :survey_responses, :survey_questions, column: :question_id
  end
end
