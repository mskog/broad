
source 'https://rubygems.org'
ruby '2.5.0'

# Standard Rails gems
gem 'rails', '~> 5.2'
gem 'bcrypt', '3.1.12'

# PostgreSQL
gem 'pg', "~> 1.0.0"

# Whitespace remover
gem 'strip_attributes', '~> 1.7'

# Configuration
gem 'dotenv-rails', '~> 2.5'

gem 'virtus', '~> 1.0.5'
gem 'virtus_convert', '~> 0.1.0'

# Feeds
gem 'feedjira', '~> 2.1.4'

gem 'clockwork', '~> 2.0'

gem 'naught', '~> 1.1'

gem 'rollbar', '~> 2.19'

gem 'faraday', '~> 0.15'
gem 'faraday-cookie_jar', '~> 0.0.6'

gem 'sass-rails', '~> 5.0'
gem 'jquery-rails', '~> 4.3.3'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 4.1.8'

# Haml
gem 'haml', '~> 5.0'

# Decorating
gem 'draper', '~> 3.0.1'

gem 'bootstrap-sass', '>= 3.3.7'
gem 'font-awesome-rails', '~> 4.6'

gem 'turbolinks', '~> 5'

gem 'sinatra', git: 'https://github.com/sinatra/sinatra' # For Fakes

# Background processing
gem 'sidekiq', '~> 5.2.2'
gem 'sidekiq-limit_fetch'

# TMDB Api
gem 'themoviedb', '~> 1.0.1'
gem 'httparty', '~> 0.16.1'

# Redis store
gem 'redis-rails', '~> 5.0.0.pre'

# Cache
# gem 'multi_fetch_fragments', '~> 0.0.17'
# gem 'actionpack-action_caching', '~> 1.1', '>= 1.1.1'

# Pagination
gem 'kaminari', '~> 1.1'
gem 'bootstrap-kaminari-views', '~> 0.0.5'

# Serializers
gem 'active_model_serializers', '~> 0.9.5'
gem 'activemodel-serializers-xml', git: 'https://github.com/rails/activemodel-serializers-xml'

# Time. DO NOT REMOVE THESE. FOR SOME REASON THE JS BUNDLE REQUIRES THEM
gem 'momentjs-rails', '~> 2.20.1'

gem 'coffee-script', '~> 2.4.1'

gem 'puma', '~> 3.12'

# Specific, older version of thor to fix the problem with Rails 5
gem 'thor', '0.20.0'

# Javascript
gem 'webpacker', '~> 3.5'
gem "react_on_rails", "11.1.4"

gem 'mini_racer', platforms: :ruby

gem 'bootsnap', '~> 1.3'

gem 'rack-cors', require: 'rack/cors'

# JSONRpc
gem 'jsonrpc-faraday', '~> 0.1'

group :development, :test do
  gem 'better_errors', '~> 2.4.0'
  gem 'binding_of_caller', platforms: [:mri_20, :mri_21, :mri_22, :mri_23, :mri_24, :mri_25]
  gem 'byebug',  '~> 10.0'
  gem 'spring', '2.0.2'
  gem "spring-commands-rspec"

  # Pry
  gem 'pry-rails', '~> 0.3.6'
end

group :test do
  gem 'capybara', '~> 3.9'
  gem 'capybara-selenium', '~> 0.0.6'
  gem 'capybara-screenshot', '~> 1.0'
  gem 'chromedriver-helper'
  gem 'webmock', '~> 3.4.2'
  gem 'factory_bot', '~> 4.11'
  gem 'faker', git: 'https://github.com/joenas/faker'
  gem 'rspec-rails', '~> 3.8'
  gem 'rspec-given', '~> 3.8'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner', '~> 1.5'
  gem 'rspec_junit_formatter', '0.4.1'
  gem 'guard-rails', '~> 0.8'
  gem 'guard-rspec', '~> 4.7'
  gem 'simplecov', :require => false
end
