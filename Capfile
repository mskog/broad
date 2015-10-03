require 'dotenv'
Dotenv.load
require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/migrations'
require 'capistrano/faster_assets'
require 'mascherano/foreman'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
