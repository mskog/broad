require "sinatra/base"

class FakeOmdb < Sinatra::Base
  get "/" do
    type = params["type"].to_s
    content_type :json
    data = data(type, params["s"] || params["i"])
    [200, data]
  end

  def data(type, query)
    file_path = "spec/fixtures/omdb/#{type}/#{query.to_s.downcase}.json"
    if File.file?(file_path)
      File.read(file_path)
    else
      File.read("spec/fixtures/omdb/noresults.json")
    end
  end

  class NotImplementedError < StandardError; end
end
