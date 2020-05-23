ActiveStorage::Service.url_expires_in = 1.week

Rails.application.routes.default_url_options[:host] = ENV["HOST"]
