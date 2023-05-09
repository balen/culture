class CreateSurveyLikertSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_likert_settings, id: :uuid do |t|
      t.jsonb :left_label, default: {}
      t.jsonb :right_label, default: {}

      t.uuid :question_id, null: false

      t.integer :lock_version
      t.timestamps
    end
    add_foreign_key :survey_likert_settings, :survey_questions, column: :question_id
  end
end
