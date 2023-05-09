class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys, id: :uuid do |t|
      t.jsonb :name, default: {}

      t.integer :lock_version
      t.timestamps
    end
  end
end
