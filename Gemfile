
source 'https://rubygems.org'
ruby '2.5.0'

# Standard Rails gems
gem 'rails', '5.0.1'
gem 'bcrypt', '3.1.11'

# PostgreSQL
gem 'pg', "~> 0.19.0"

# Whitespace remover
gem 'strip_attributes', '~> 1.7'

# Configuration
gem 'dotenv-rails', '~> 2.2'

gem 'virtus', '~> 1.0.5'
gem 'virtus_convert', '~> 0.1.0'

# Feeds
gem 'feedjira', '~> 2.0.0'

gem 'clockwork', '~> 2.0'

gem 'naught', '~> 1.1'

gem 'rollbar', '~> 2.13'

gem 'faraday', '~> 0.9'
gem 'faraday-cookie_jar', '~> 0.0.6'

gem 'sass-rails', '~> 5.0'
gem 'jquery-rails', '~> 4.2.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 4.1.8'

# Haml
gem 'haml', '~> 4.0'

# Decorating
# gem 'draper', '~> 2.1.0'
gem 'draper', '~> 3.0.0.pre1'

gem 'bootstrap-sass', '>= 3.3.7'
gem 'font-awesome-rails', '~> 4.6'

gem 'therubyracer', '~> 0.12.3', platforms: :ruby
gem 'turbolinks', '~> 5'

gem 'sinatra', git: 'https://github.com/sinatra/sinatra' # For Fakes

# Background processing
gem 'sidekiq', '~> 5.1.3'
gem 'sidekiq-limit_fetch'
gem 'sidekiq-unique-jobs'

# TMDB Api
gem 'themoviedb', '~> 1.0.1'
gem 'httparty', '~> 0.16.1'

# Redis store
gem 'redis-rails', '~> 5.0.0.pre'

# Cache
gem 'multi_fetch_fragments', '~> 0.0.17'
# gem 'actionpack-action_caching', '~> 1.1', '>= 1.1.1'

# Pagination
gem 'kaminari', '~> 1.1'
gem 'bootstrap-kaminari-views', '~> 0.0.5'

# React
gem 'react_webpack_rails', git: 'https://github.com/netguru/react_webpack_rails'
gem 'rwr-view_helpers'

# Serializers
gem 'active_model_serializers', '~> 0.9.5'
gem 'activemodel-serializers-xml', git: 'https://github.com/rails/activemodel-serializers-xml'

# Time. DO NOT REMOVE THESE. FOR SOME REASON THE JS BUNDLE REQUIRES THEM
gem 'momentjs-rails', '~> 2.15.1'

gem 'coffee-script', '~> 2.4.1'

gem 'puma', '~> 3.11'

# Specific, older version of thor to fix the problem with Rails 5
gem 'thor', '0.19.1'

group :development, :test do
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', platforms: [:mri_20, :mri_21, :mri_22, :mri_23]
  gem 'guard-rails', '~> 0.8'
  gem 'guard-rspec', '~> 4.7'
  gem 'byebug',  '~> 9.0'
  gem 'factory_girl_rails', '~> 4.7'
  gem 'faker', git: 'https://github.com/joenas/faker'
  gem 'rspec-rails', '~> 3.5'
  gem 'rspec-given', '~> 3.8'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner', '~> 1.5'
  # gem 'quiet_assets', '~> 1.1.0'
  # gem 'rack-mini-profiler', git: 'https://github.com/MiniProfiler/rack-mini-profiler'

  # Spring
  gem 'spring', '2.0.0'
  gem "spring-commands-rspec"

  # Pry
  gem 'pry-rails', '~> 0.3.6'

  gem 'rspec_junit_formatter', '0.2.3'
end

group :development, :test do
  gem 'webmock', '~> 3.3.0'
  gem 'simplecov', :require => false
  gem 'codeclimate-test-reporter', '~> 0.6.0', require: false
end
