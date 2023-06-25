class AddShortCodes < ActiveRecord::Migration[7.0]
  def change
    add_column :survey_groups, :short_code, :string, limit: 40, after: "id"
    add_column :survey_questions, :short_code, :string, limit: 40, after: "id"
    add_column :survey_responses, :short_code, :string, limit: 40, after: "id"
  end
end
