class AddColumnAskedToSubmission < ActiveRecord::Migration[7.0]
  def change
    add_column :survey_submissions, :questions, :uuid, array:true, default: []
  end
end
