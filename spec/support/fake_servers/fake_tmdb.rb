require 'sinatra/base'

class FakeTmdb < Sinatra::Base
  get '/3/search/tv' do
    query = params["query"]
    data = tv_show_data(query)
    content_type :json
    [200, data]
  end

  get '/3/tv/404*' do
    content_type :json
    data = {"status_code"=>34, "status_message"=>"The resource you requested could not be found."}
    [200, JSON.generate(data)]
  end

  get '/3/tv/:show_id/season/:season/episode/:episode' do
    show_id = params["show_id"]
    season = params["season"]
    episode = params["episode"]
    data = tv_episode_data(show_id, season, episode)
    content_type :json
    [200, data]
  end


  get '/*' do
    raise NotImplementedError, "'#{self.url}' is not implemented in this fake"
  end

  private

  def tv_show_data(query)
    file_path = "spec/fixtures/tmdb/tv/#{query}.json"
    if File.file?(file_path)
      File.read(file_path)
    else
      File.read("spec/fixtures/tmdb/tv/default.json")
    end
  end

  def tv_episode_data(show_id, season, episode)
    file_path = "spec/fixtures/tmdb/tv/episodes/#{show_id}/s#{season}e#{episode}.json"
    if File.file?(file_path)
      File.read(file_path)
    else
      File.read("spec/fixtures/tmdb/tv/episodes/default.json")
    end
  end

  class NotImplementedError < StandardError; end
end
