require 'sinatra/base'

class FakeTrakt < Sinatra::Base
  get '/search' do
    data = search_data(params)
    content_type :json
    [200, data]
  end

  get '/3/tv/404*' do
    content_type :json
    data = {"status_code"=>34, "status_message"=>"The resource you requested could not be found."}
    [200, JSON.generate(data)]
  end

  get '/*' do
    raise NotImplementedError, "'#{self.url}' is not implemented in this fake"
  end

  private

  def search_data(params)
    if params.key?('id_type')
      search_data_id(params)
    else
      search_data_query(params)
    end
  end

  def search_data_query(params)
    file_path = "spec/fixtures/trakt/search/#{params['type']}_#{params['query']}.json".downcase
    if File.file?(file_path)
      File.read(file_path)
    else
      File.read("spec/fixtures/trakt/search/show_default.json")
    end
  end

  def search_data_id(params)
    file_path = "spec/fixtures/trakt/search/#{params['id']}.json"
    if File.file?(file_path)
      File.read(file_path)
    else
      File.read("spec/fixtures/trakt/search/show_default.json")
    end
  end

  class NotImplementedError < StandardError; end
end
