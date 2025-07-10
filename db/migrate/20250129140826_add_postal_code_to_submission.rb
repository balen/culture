class AddPostalCodeToSubmission < ActiveRecord::Migration[7.0]
  def change
    add_column :survey_submissions, :postal_code, :string, limit: 20, default: nil
  end
end
