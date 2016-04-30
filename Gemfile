
source 'https://rubygems.org'
ruby '2.2.0'

# Standard Rails gems
gem 'rails', '4.2.6'
gem 'bcrypt', '3.1.11'

# PostgreSQL
gem 'pg', "~> 0.18.4"

# Whitespace remover
gem 'strip_attributes', '~> 1.7'

# Configuration
gem 'dotenv-rails', '~> 2.1'

gem 'virtus', '~> 1.0.5'
gem 'virtus_convert', '~> 0.1.0'

# Feeds
gem 'feedjira', '~> 2.0.0'

gem 'clockwork', '~> 2.0'

gem 'naught', '~> 1.1'

gem 'rollbar', '~> 2.9'

gem 'faraday', '~> 0.9'
gem 'faraday-cookie_jar', '~> 0.0.6'

gem 'sass-rails', '~> 5.0.4'
gem 'jquery-rails', '~> 4.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 3.0'

# Haml
gem 'haml-rails', '~> 0.9.0'

# Decorating
gem 'draper', '~> 2.1.0'

gem 'bootstrap-sass', '>= 3.3.6'
gem 'font-awesome-rails', '~> 4.6'

gem 'therubyracer', '~> 0.12.1', platforms: :ruby
# gem 'turbolinks', '~> 2.5', '>= 2.5.3'
gem 'turbolinks', "~> 5.0.0.beta2"

gem 'sinatra', '~> 1.4' # For Fakes

# Background processing
gem 'sidekiq', '< 5'
gem 'sidekiq-limit_fetch'

# OMDB api
gem 'omdb', git: 'https://github.com/jvanbaarsen/omdb'

# TMDB Api
gem 'themoviedb', '~> 1.0'

# Redis store
gem 'redis-rails', '~> 4.0'

# Cache
gem 'multi_fetch_fragments', '~> 0.0.17'
gem 'actionpack-action_caching', '~> 1.1', '>= 1.1.1'

# Pagination
gem 'kaminari', '~> 0.16'
gem 'bootstrap-kaminari-views', '~> 0.0.5'

# React
gem 'react_webpack_rails', git: 'https://github.com/netguru/react_webpack_rails'

# Serializers
gem 'active_model_serializers', '~> 0.9.5'

# Time. DO NOT REMOVE THESE. FOR SOME REASON THE JS BUNDLE REQUIRES THEM
gem 'rails-timeago', '~> 2.13'
gem 'momentjs-rails', '~> 2.11'

group :development, :test do
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', platforms: [:mri_20, :mri_21, :mri_22]
  gem 'guard-rails', '~> 0.7'
  gem 'guard-rspec', '~> 4.6'
  gem 'byebug',  '~> 8.2'
  gem 'factory_girl_rails', '~> 4.7'
  gem 'faker', git: 'https://github.com/joenas/faker'
  gem 'rspec-rails', '~> 3.4'
  gem 'rspec-given', '~> 3.8'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner', '~> 1.5'
  gem 'quiet_assets', '~> 1.1.0'

  gem 'capistrano', '~> 3.4.0'
  gem "capistrano-rails"
  gem 'capistrano-rbenv'
  gem 'capistrano-faster-assets'
  gem 'capistrano-db-tasks', git: "https://github.com/sgruhier/capistrano-db-tasks", require: false
  gem 'mascherano'
  gem 'capistrano-npm'
  # gem 'rack-mini-profiler', git: 'https://github.com/MiniProfiler/rack-mini-profiler'

  # Spring
  gem 'spring', '1.7.1'
  gem "spring-commands-rspec"

  # Pry
  gem 'pry-rails', '~> 0.3.2'

  gem 'rspec_junit_formatter', '0.2.3'
end

group :test do
  gem 'webmock', '~> 1.24'
  gem 'simplecov', :require => false
end
