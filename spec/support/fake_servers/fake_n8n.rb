require "sinatra/base"

class FakeN8n < Sinatra::Base
  get "/webhook/#{ENV['N8N_MOVIE_RELEASE_DATES_ID']}" do
    data = JSON.parse(File.read("spec/fixtures/n8n/movie_release_dates.json"))

    content_type :json
    [200, data.to_json]
  end

  class NotImplementedError < StandardError; end
end
