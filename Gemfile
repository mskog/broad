source 'https://rubygems.org'
ruby '2.2.0'

# Standard Rails gems
gem 'rails', '4.2.4'
gem 'bcrypt', '3.1.10'

# PostgreSQL
gem 'pg', "~> 0.18.3"

# Whitespace remover
gem 'strip_attributes', '~> 1.7'

# Configuration
gem 'dotenv-rails', '~> 2.0'

gem 'virtus', '~> 1.0.5'

# Feeds
gem 'feedjira', '~> 2.0.0'

gem 'clockwork', '~> 1.2.0'

gem 'naught', '~> 1.1'

gem 'rollbar', '~> 2.3'

gem 'faraday', '~> 0.9'
gem 'faraday-cookie_jar', '~> 0.0.6'

gem 'sass-rails', '~> 5.0.4'
gem 'jquery-rails', '~> 4.0.5'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 2.7.2'

# Haml
gem 'haml-rails', '~> 0.9.0'

# Decorating
gem 'draper', '~> 2.1.0'

gem 'bootstrap-sass', '>= 3.3.5.1'
gem 'font-awesome-rails', '~> 4.4.0'

gem 'therubyracer', '~> 0.12.1', platforms: :ruby
gem 'turbolinks', '~> 2.5.3'

gem 'sinatra', '~> 1.4.4' # For Fakes

# Background processing
gem 'sidekiq', '~> 3.5.1'
gem 'sidekiq-limit_fetch'

# OMDB api
gem 'omdb', git: 'https://github.com/jvanbaarsen/omdb'

# TMDB Api
gem 'themoviedb', '~> 0.1.0'

# Redis store
gem 'redis-rails', '~> 4.0'

# Multi fetch cache
gem 'multi_fetch_fragments', '~> 0.0.17'

group :development, :test do
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', platforms: [:mri_20, :mri_21, :mri_22]
  gem 'guard-rails', '~> 0.7'
  gem 'guard-rspec', '~> 4.6'
  gem 'byebug', '6.0.2'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'faker', git: 'https://github.com/joenas/faker'
  gem 'rspec-rails', '~> 3.3.2'
  gem 'rspec-given', '~> 3.7.0'
  gem 'shoulda-matchers', '~> 3.0'
  gem 'database_cleaner', '~> 1.5'
  gem 'quiet_assets', '~> 1.1.0'

  gem 'capistrano', '~> 3.4.0'
  gem "capistrano-rails"
  gem 'capistrano-rbenv'
  gem 'capistrano-faster-assets'
  gem 'mascherano'

  # Spring: https://github.com/rails/spring
  gem 'spring', '1.4.0'
  gem "spring-commands-rspec"

  # Pry
  gem 'pry-rails', '~> 0.3.2'

  gem 'rspec_junit_formatter', '0.2.3'
end

group :test do
  gem 'webmock', '~> 1.21'
  gem 'simplecov', :require => false
end
