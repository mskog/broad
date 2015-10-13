require 'sinatra/base'

class FakePTP < Sinatra::Base
  post '/ajax.php' do
    action = params["action"]

    if action == 'login'
      login
    end

  end

  get '/torrents.php' do
    searchstr = params["searchstr"]
    data = torrent_data(searchstr)
    [200, data]
  end

  get '/*' do
    raise NotImplementedError, "'#{self.url}' is not implemented in this fake"
  end

  private

  def login
    [200, ""]
  end

  def torrent_data(searchstr)
    file_path = "spec/fixtures/ptp/#{searchstr}.json"
    if File.file?(file_path)
      File.read(file_path)
    else
      File.read("spec/fixtures/ptp/noresults.json")
    end
  end

  class NotImplementedError < StandardError; end
end
