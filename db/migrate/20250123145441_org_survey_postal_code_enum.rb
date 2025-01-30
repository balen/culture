class OrgSurveyPostalCodeEnum < ActiveRecord::Migration[7.0]
  def change
    reversible do |change|
      change.down do
        remove_column :organization_surveys, :use_postal_code

        execute <<-SQL
          DROP TYPE use_postal_code_enum;
        SQL
      end
      change.up do
        execute <<-SQL
          CREATE TYPE use_postal_code_enum AS ENUM ('none', 'usa', 'canada', 'uk', 'rotw');
        SQL

        add_column :organization_surveys, :use_postal_code, :use_postal_code_enum, default: 'none'
      end
    end
  end
end
