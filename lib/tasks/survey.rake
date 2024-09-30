namespace :survey do
  desc "Initialize Questions"
  task :initialize => :environment do
    # puts "--- survey init started"
    Survey.transaction do
      next if Survey.count > 0

      survey = ::Survey::CultureData.create_survey
    end
    puts "--- survey init finished"
  end

  desc "Update the survey questions"
  task :update => :environment do
    puts "--- survey update started"
    Survey.transaction do
      next if Survey.count == 0

      survey = ::Survey::CultureData.create_survey
    end
    puts "--- survey update finished"
  end

  desc "Update the survey questions"
  task :init_or_update => :environment do
    puts "--- survey init_or_update started"
    Survey.transaction do
      survey = ::Survey::CultureData.create_survey
    end
    puts "--- survey init_or_update finished"
  end
end
