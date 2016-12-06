web: bundle exec rails server -p ${PORT-3000} -b ${IP-0.0.0.0}
worker: bundle exec sidekiq -C config/sidekiq.yml
scheduler: bundle exec clockwork config/clock.rb
