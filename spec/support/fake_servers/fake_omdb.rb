require 'sinatra/base'

class FakeOmdb < Sinatra::Base
  get '/' do
    imdb_id = params["i"]
    data = omdb_data(imdb_id)
    content_type :json
    [200, data]
  end

  get '/*' do
    raise NotImplementedError, "'#{self.url}' is not implemented in this fake"
  end

  private

  def omdb_data(imdb_id)
    file_path = "spec/fixtures/omdb/#{imdb_id}"
    if File.file?(file_path)
      File.read(file_path)
    else
      File.read("spec/fixtures/omdb/default.json")
    end
  end

  class NotImplementedError < StandardError; end
end
