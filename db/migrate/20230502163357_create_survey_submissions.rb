class CreateSurveySubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_submissions, id: :uuid do |t|
      t.string :name
      t.uuid :survey_id, null: false

      t.integer :lock_version
      t.timestamps
    end
    add_foreign_key :survey_submissions, :surveys, column: :survey_id
  end
end
