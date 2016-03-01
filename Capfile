require 'dotenv'
Dotenv.load
require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/faster_assets'
require 'mascherano/foreman'
require 'capistrano-db-tasks'

Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }

