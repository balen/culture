source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2" # Ruby > 3
gem "rails", "~> 7.0.4", ">= 7.0.4.3" # Rails version
# gem "sprockets-rails" # Do we need this - TODO: check
gem "pg", "~> 1.1" # Use postgresql as the database for Active Record
gem "puma", "~> 5.0" # Use the Puma web server [https://github.com/puma/puma]

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
# gem "cssbundling-rails" # TODO: check is needed with vite

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# 
gem 'devise'
gem 'fast_excel'
gem 'kaminari'
gem 'nilify_blanks'
gem 'rails-i18n', '~> 7.0.0'
gem 'jsonapi-serializer'
gem 'jsonapi.rb'
gem 'mobility', '~> 1.3.0.rc1'
gem "nokogiri"
gem 'pundit'
gem 'ransack'
gem 'routing-filter'
gem "vite_rails", "~> 3.0"
gem 'vite_plugin_legacy'

group :staging, :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "brakeman"                                      # vulnerability and static analysis
  gem "ruby_audit"                                    # checks for CVEs affecting Ruby and RubyGems
  gem 'faker'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'seedbank'
  gem 'factory_bot_rails'
end

group :development do
  gem 'rubocop'
end

