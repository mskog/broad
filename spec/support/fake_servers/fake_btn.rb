require "sinatra/base"

class FakeBtn < Sinatra::Base
  post "/*" do
    content_type :json
    body = JSON.parse(request.body.read)
    send(body["method"].underscore, body["id"], body["params"])
  end

  private

  def get_torrents(request_id, params)
    if params[1].is_a?(Hash)
      if params[1]["category"] == "season"
        return get_torrents_season(request_id, params[1])
      elsif params[1]["name"].present?
        name = "#{params[1]['tvdb']}_#{params[1]['name']}"
      else
        name = params[1]["series"].presence || params[1]["tvdb"].to_s
      end
    else
      name = params[1]
    end
    path = "spec/fixtures/btn/getTorrents/#{name.downcase}.json"

    result = if File.exist?(path)
               File.read(path)
             else
               File.read("spec/fixtures/btn/getTorrents/empty.json")
             end

    response = {id: request_id, result: result}.to_json
    [200, response]
  end

  def get_torrents_season(request_id, attributes)
    name = "#{attributes['tvdb']}_#{attributes['name'].downcase.tr(' ', '_')}.json"
    path = "spec/fixtures/btn/getTorrents/season/#{name}"

    result = if File.exist?(path)
               File.read(path)
             else
               File.read("spec/fixtures/btn/getTorrents/empty.json")
             end

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
