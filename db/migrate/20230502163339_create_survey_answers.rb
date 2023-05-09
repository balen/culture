class CreateSurveyAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_answers, id: :uuid do |t|
      t.jsonb :answer, default: {}

      t.uuid :question_id, null: false

      t.integer :lock_version
      t.timestamps
    end
    add_foreign_key :survey_answers, :survey_questions, column: :question_id
  end
end
