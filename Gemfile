source 'https://rubygems.org'

ruby "1.9.3"

gem 'rails', '~> 3.2.16'
gem 'mongoid', '2.4.12'
gem 'mongoid_spacial'
gem 'bson_ext', '1.6.4'

gem 'dotenv-rails'

gem 'foreman', '< 0.84.0'
gem 'thin'

gem 'exception_notification', '2.6.1'
gem 'aws-ses', '0.6.0', :require => 'aws/ses'

gem 'carrierwave'
gem 'carrierwave-mongoid', '0.2.2', :require => 'carrierwave/mongoid'
gem 'fog', '>= 1.16.0'

gem 'state_machine', '1.2.0'

gem 'delayed_job', '3.0.5'
gem 'delayed_job_mongoid', '1.1.0'

gem 'mini_magick'

if ENV['BUNDLE_DEV']
  gem 'gds-sso', path: '../gds-sso'
else
  gem 'gds-sso', '3.0.5'
end

gem 'plek', '2.0.0'

group :assets do
  gem 'uglifier', '>= 3.2.0'
end

group :development, :test do
  gem 'rspec-rails', '2.12.2'
  gem 'database_cleaner', '0.9.1'

  gem 'simplecov-rcov', '0.2.3'
  gem 'ci_reporter', '1.8.4'

  gem "factory_girl_rails", "~> 4.0"
  gem "pry"
end

group :production do
  gem "rails_12factor"
end
