source "https://rubygems.org"
ruby "2.6.2"

# Standard Rails gems
gem "bcrypt", "3.1.12"
gem "rails", "~> 5.2"

# PostgreSQL
gem "pg", "~> 1.0.0"

# Whitespace remover
gem "strip_attributes", "~> 1.7"

# Configuration
gem "dotenv-rails", "~> 2.5"

gem "virtus", "~> 1.0.5"
gem "virtus_convert", "~> 0.1.0"

# Feeds
gem "feedjira", "~> 2.1.4"

gem "clockwork", "~> 2.0"

gem "naught", "~> 1.1"

gem "rollbar", "~> 2.16"

gem "faraday", "~> 0.15"
gem "faraday-cookie_jar", "~> 0.0.6"

gem "jquery-rails", "~> 4.3.3"
gem "sass-rails", "~> 5.0"

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 4.1.8"

# Haml
gem "haml", "~> 5.0"

# Decorating
gem "draper", "~> 3.0.1"

gem "bootstrap-sass", ">= 3.3.7"
gem "font-awesome-rails", "~> 4.6"

gem "turbolinks", "~> 5"

gem "sinatra", git: "https://github.com/sinatra/sinatra" # For Fakes

# Background processing
gem "sidekiq", "~> 5.2.7"
gem "sidekiq-limit_fetch"

# TMDB Api
gem "httparty", "~> 0.16.1"
gem "themoviedb", "~> 1.0.1"

# Redis store
gem "redis-rails", "~> 5.0.0.pre"

# Cache
# gem 'multi_fetch_fragments', '~> 0.0.17'
# gem 'actionpack-action_caching', '~> 1.1', '>= 1.1.1'

# Pagination
gem "bootstrap-kaminari-views", "~> 0.0.5"
gem "kaminari", "~> 1.1"

# Serializers
gem "active_model_serializers", "~> 0.9.5"
gem "activemodel-serializers-xml", git: "https://github.com/rails/activemodel-serializers-xml"

# Time. DO NOT REMOVE THESE. FOR SOME REASON THE JS BUNDLE REQUIRES THEM
gem "momentjs-rails", "~> 2.20.1"

gem "coffee-script", "~> 2.4.1"

gem "puma", "~> 3.12"

# Specific, older version of thor to fix the problem with Rails 5
gem "thor", "0.20.0"

gem "bootsnap", "~> 1.4"

gem "rack-cors", require: "rack/cors"

# JSONRpc
gem "jsonrpc-faraday", "~> 0.1"

group :development, :test do
  gem "better_errors", "~> 2.4.0"
  gem "binding_of_caller", platforms: %i[mri_20 mri_21 mri_22 mri_23 mri_24 mri_25]
  gem "byebug", "~> 10.0"
  gem "rubocop", "~> 0.74.0"
  gem "spring", "2.0.2"
  gem "spring-commands-rspec"
  gem 'spring-commands-rubocop'

  # Pry
  gem "pry-rails", "~> 0.3.6"
end

group :test do
  gem "database_cleaner", "~> 1.7"
  gem "factory_bot", "~> 5.0.2"
  gem "faker", git: "https://github.com/joenas/faker"
  gem "guard-rails", "~> 0.8"
  gem "guard-rspec", "~> 4.7"
  gem "rspec-given", "~> 3.8"
  gem "rspec-rails", "~> 3.8"
  gem "rspec_junit_formatter", "0.4.1"
  gem "shoulda-matchers", "~> 3.1"
  gem "simplecov", :require => false
  gem "webmock", "~> 3.6"
end
