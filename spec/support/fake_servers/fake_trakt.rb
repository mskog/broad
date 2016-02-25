require 'sinatra/base'

class FakeTrakt < Sinatra::Base
  get '/search' do
    data = search_data(params)
    content_type :json
    [200, data]
  end

  get '/*' do
    raise NotImplementedError, "'#{self.url}' is not implemented in this fake"
  end

  private

  def search_data(params)
    file_path = "spec/fixtures/trakt/search/#{params['type']}_#{params['query']}.json"
    if File.file?(file_path)
      File.read(file_path)
    else
      File.read("spec/fixtures/trakt/search/show_default.json")
    end
  end

  class NotImplementedError < StandardError; end
end
