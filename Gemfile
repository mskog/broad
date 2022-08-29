source "https://rubygems.org"
ruby "3.1.0"

# Standard Rails gems
gem "bcrypt", "3.1.18"
gem "rails", "~> 7.0"
gem "sprockets-rails"

# PostgreSQL
gem "pg", "~> 1.4.2"
gem 'pg_search', '~> 2.3', '>= 2.3.5'


# Configuration
gem "dotenv-rails", "~> 2.8"

gem "dry-struct", "~> 1.4"

# Feeds
gem "feedjira", "~> 3.1"

gem "clockwork", "~> 3.0"

gem "naught", "~> 1.1"

gem "rollbar", "~> 3.2"

gem "faraday", "~> 1.10"
gem "faraday-cookie_jar", "~> 0.0.6"
gem "http", "~> 5.1.0"

gem "sinatra"

# Background processing
gem "sidekiq", "~> 6.5.1"
gem "sidekiq-limit_fetch"

# TMDB Api
gem "httparty", "~> 0.20.0"
gem "themoviedb", "~> 1.0.1"


gem 'down', '~> 5.3'

# Cache
# gem 'multi_fetch_fragments', '~> 0.0.17'
gem "actionpack-action_caching", '~> 1.2.2'

gem "puma", "~> 5.6"
gem 'rack-attack', '~> 6.6'

# Specific, older version of thor to fix the problem with Rails 5
gem "thor", "1.2.1"

gem "bootsnap", "~> 1.13"

gem "rack-cors", require: "rack/cors"

# JSONRpc
gem "jsonrpc-faraday", "~> 0.1"

gem "rb-readline"

gem "graphql", "~> 2.0.12"

group :development, :test do
  gem "better_errors", "~> 2.9.1"
  gem "binding_of_caller"
  gem "byebug", "~> 11.1"
  gem "rubocop", "~> 1.35"
  gem "rubocop-rails"
  gem "rubocop-rspec"
  gem "spring", "4.0.0"
  gem "spring-commands-rspec"
  gem "pry-rails", "~> 0.3.6"
end

group :test do
  gem "database_cleaner", "~> 2.0"
  gem "factory_bot", "~> 6.2.1"
  gem "faker"
  gem "guard-rails", "~> 0.8"
  gem "guard-rspec", "~> 4.7"
  gem "rspec-given", "~> 3.8"
  gem "rspec_junit_formatter", "0.5.1"
  gem "rspec-rails", "~> 5.1"
  gem "shoulda-matchers", "~> 5.1"
  gem "simplecov", :require => false
  gem "webmock", "~> 3.8"
end

gem "graphiql-rails", group: :development
