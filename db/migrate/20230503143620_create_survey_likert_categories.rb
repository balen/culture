class CreateSurveyLikertCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_likert_categories, id: :uuid do |t|
      t.jsonb :label, default: {}
      t.integer :value
      t.integer :order

      t.uuid :likert_setting_id, null: false

      t.integer :lock_version
      t.timestamps
    end
    add_foreign_key :survey_likert_categories, :survey_likert_settings, column: :likert_setting_id
  end
end
