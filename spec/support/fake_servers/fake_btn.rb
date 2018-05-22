require 'sinatra/base'

class FakeBtn < Sinatra::Base
  post '/*' do
    content_type :json
    body = JSON.parse(request.body.read)
    send(body['method'], body['id'], body['params'])
  end

  private

  def getTorrents(request_id, params)
    if params[1].is_a?(Hash)
      name = params[1]['series'].presence || params[1]['tvdb'].to_s
    else
      name = params[1]
    end
    result = (File.read("spec/fixtures/btn/getTorrents/#{name.downcase}.json"))

    response = {id: request_id, result: result}.to_json
    [200, response]
  end

  # def torrent_data(searchstr)
  #   file_path = "spec/fixtures/ptp/#{searchstr}.json"
  #   if File.file?(file_path)
  #     File.read(file_path)
  #   else
  #     File.read("spec/fixtures/ptp/noresults.json")
  #   end
  # end

  class NotImplementedError < StandardError; end
end
