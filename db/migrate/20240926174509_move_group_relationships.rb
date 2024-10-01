class MoveGroupRelationships < ActiveRecord::Migration[7.0]
  def up
      query = <<-SQL.squish
        insert into survey_groups_surveys (group_id, survey_id)
        select id, survey_id from survey_groups;
      SQL

      ActiveRecord::Base.connection.execute(query)
  end

  def down 
      query = <<-SQL.squish
        truncate table survey_groups_surveys;
      SQL

      ActiveRecord::Base.connection.execute(query)    
  end
end
