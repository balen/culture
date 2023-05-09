class CreateSurveyGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_groups, id: :uuid do |t|
      t.jsonb :name, default: {}
      t.uuid :survey_id, null: false

      t.integer :lock_version
      t.timestamps
    end
    add_foreign_key :survey_groups, :surveys, column: :survey_id
  end
end
