module MigrationHelpers
  module CultureViews
    def self.create_views
      self.create_responses_view
    end

    def self.drop_views
      ActiveRecord::Base.connection.execute <<-SQL
        DROP VIEW IF EXISTS responses_view;
      SQL
    end

    def self.create_responses_view
      ActiveRecord::Base.connection.execute <<-SQL
        DROP VIEW IF EXISTS responses_view;
      SQL

      query = <<-SQL.squish
        CREATE OR REPLACE VIEW responses_view AS
        select
          sr.id as response_id,
          sr.question_id,
          sr.response,
          sr.response_as_text,
          sq.short_code,
          o.name as organization_name,
          os.organization_id,
          os.access_code,
          sq.group_id,
          sg.short_code as group_short_code,
          ss.id as submission_id
          from survey_responses sr 
          join survey_questions sq  on sq.id = sr.question_id
          join survey_groups sg  on sg.id = sq.group_id
          join survey_submissions ss on ss.id = sr.submission_id 
          join organization_surveys os on os.survey_id = ss.survey_id
          join organizations o on o.id = os.organization_id;
      SQL
      ActiveRecord::Base.connection.execute(query)
    end
  end
end
