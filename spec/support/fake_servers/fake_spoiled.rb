require "sinatra/base"

class FakeSpoiled < Sinatra::Base
  get "/" do
    title = params["title"].to_s
    data = {
      title: title,
      score: rand(1..100),
      url: "http://www.rottentomatoes.com/m/#{title.underscore}"
    }
    content_type :json
    [200, data.to_json]
  end

  class NotImplementedError < StandardError; end
end
