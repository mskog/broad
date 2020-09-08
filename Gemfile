source "https://rubygems.org"
ruby "2.6.6"

# Standard Rails gems
gem "bcrypt", "3.1.16"
gem "rails", "~> 5.2"

# PostgreSQL
gem "pg", "~> 1.2.3"

# Whitespace remover
gem "strip_attributes", "~> 1.7"

# Configuration
gem "dotenv-rails", "~> 2.7"

gem "virtus", "~> 1.0.5"
gem "virtus_convert", "~> 0.1.0"

# Feeds
gem "feedjira", "~> 2.1.4"

gem "clockwork", "~> 2.0"

gem "naught", "~> 1.1"

gem "rollbar", "~> 3.0"

gem "faraday", "~> 0.15"
gem "faraday-cookie_jar", "~> 0.0.6"

# Decorating
gem "draper", "~> 4.0.1"

gem "sinatra", git: "https://github.com/sinatra/sinatra" # For Fakes

# Background processing
gem "sidekiq", "~> 6.1.0"
gem "sidekiq-limit_fetch"

# TMDB Api
gem "httparty", "~> 0.18.1"
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

gem "puma", "~> 4.3"

# Specific, older version of thor to fix the problem with Rails 5
gem "thor", "1.0.1"

gem "bootsnap", "~> 1.4"

gem "rack-cors", require: "rack/cors"

# JSONRpc
gem "jsonrpc-faraday", "~> 0.1"

gem "rb-readline"

gem "newrelic_rpm", "~> 6.12", ">= 6.12.0.367"

gem "graphql", "~> 1.11"
gem "search_object"
gem "search_object_graphql"

group :development, :test do
  gem "better_errors", "~> 2.7.1"
  gem "binding_of_caller"
  gem "byebug", "~> 11.1"
  gem "rubocop", "~> 0.74.0"
  gem "spring", "2.1.0"
  gem "spring-commands-rspec"
  gem "spring-commands-rubocop"
  # Pry
  gem "pry-rails", "~> 0.3.6"
end

group :test do
  gem "database_cleaner", "~> 1.7"
  gem "factory_bot", "~> 6.1.0"
  gem "faker"
  gem "guard-rails", "~> 0.8"
  gem "guard-rspec", "~> 4.7"
  gem "rspec-given", "~> 3.8"
  gem "rspec-rails", "~> 3.8"
  gem "rspec_junit_formatter", "0.4.1"
  gem "shoulda-matchers", "~> 4.3"
  gem "simplecov", :require => false
  gem "webmock", "~> 3.8"
end

gem "graphiql-rails", group: :development
