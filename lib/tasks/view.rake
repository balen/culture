namespace :views do
  desc "Ensure that the views are correct"
  task recreate: :environment do
    MigrationHelpers::CultureViews.drop_views
    MigrationHelpers::CultureViews.create_views
  end
end