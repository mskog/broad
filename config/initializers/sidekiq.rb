# typed: strict
Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL']}
end

Sidekiq.default_worker_options = {
  unique: :until_and_while_executing,
  unique_args: ->(args) {[ args.first.except('job_id') ] }
}
