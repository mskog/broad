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

gem 'rollbar', '~> 2.3.0'

group :development, :test do
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', platforms: [:mri_20, :mri_21]
  gem 'guard-rails', '~> 0.7'
  gem 'guard-rspec', '~> 4.6'
  gem 'byebug', '6.0.2'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'faker', git: 'https://github.com/joenas/faker'
  gem 'rspec-rails', '~> 3.3.2'
  gem 'rspec-given', '~> 3.7.0'
  gem 'shoulda-matchers', '~> 2.8.0'
  gem 'database_cleaner', '~> 1.5'

  gem 'capistrano', '~> 3.4.0'
  gem "capistrano-rails"
  gem 'capistrano-rbenv'
  gem 'mascherano'

  # Spring: https://github.com/rails/spring
  gem 'spring', '1.4.0'
  gem "spring-commands-rspec"

  # Pry
  gem 'pry-rails', '~> 0.3.2'
end

group :test do
  gem 'webmock', '~> 1.21.0'
end
