class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations, id: :uuid do |t|
      t.text :name

      t.integer :lock_version
      t.timestamps
    end
  end
end
