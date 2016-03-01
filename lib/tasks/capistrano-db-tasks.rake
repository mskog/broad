# This is used by lib/capistrano/tasks/capistrano-db-tasks-monkey-patch.cap
# See https://github.com/sgruhier/capistrano-db-tasks/pull/54
namespace :capistrano_db_tasks do
  task :config => :environment do
    puts ActiveRecord::Base.configurations[Rails.env].to_yaml
  end
end
