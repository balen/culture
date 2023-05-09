class AddOrganizationToSubmission < ActiveRecord::Migration[7.0]
  def change
    # add_column :survey_submissions, :organization_id, :uuid, null: false
    # add_foreign_key :survey_submissions, :organizations, column: :organization_id

    add_column :survey_submissions, :organization_survey_id, :uuid, null: false
    add_foreign_key :survey_submissions, :organization_surveys, column: :organization_survey_id
  end
end
