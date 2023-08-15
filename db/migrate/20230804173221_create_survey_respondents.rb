class CreateSurveyRespondents < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_respondents, id: :uuid do |t|
      t.string :respondent_id, index: true

      t.integer :lock_version
      t.timestamps
    end

    add_column :survey_submissions, :survey_respondent_id, :uuid, null: true
    add_foreign_key :survey_submissions, :survey_respondents, column: :survey_respondent_id
  end
end
