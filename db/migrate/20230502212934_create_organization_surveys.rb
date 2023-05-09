class CreateOrganizationSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_surveys, id: :uuid do |t|
      t.uuid :organization_id, null: false
      t.uuid :survey_id, null: false

      t.text :access_code, null: false

      t.integer :lock_version
    end
    add_foreign_key :organization_surveys, :organizations, column: :organization_id
    add_foreign_key :organization_surveys, :surveys, column: :survey_id
  end
end
