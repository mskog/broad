require 'sinatra/base'

class FakeTrakt < Sinatra::Base
  get '/search' do
    data = search_data(params)
    content_type :json
    [200, data]
  end

  get '/calendars/my/shows*' do
    data = show_calendar_data(params)
    content_type :json
    [200, data]
  end

  get '/recommendations/movies*' do
    data = movie_recommendation_data(params)
    content_type :json
    [200, data]
  end

  delete '/recommendations/movies/:id' do
    204
  end

  get '/users/me/history/shows*' do
    data = user_history_shows_data(params)
    content_type :json
    [200, data]
  end

  get '/users/me/history/movies*' do
    data = user_history_movies_data(params)
    content_type :json
    [200, data]
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

  def show_calendar_data(params)
    file_path = "spec/fixtures/trakt/calendars/shows.json"
    if File.file?(file_path)
      File.read(file_path)
    end
  end

  def movie_recommendation_data(params)
    file_path = "spec/fixtures/trakt/recommendations/movies.json"
    if File.file?(file_path)
      File.read(file_path)
    end
  end

  def user_history_shows_data(params)
    file_path = "spec/fixtures/trakt/user/history_shows.json"
    if File.file?(file_path)
      File.read(file_path)
    end
  end

  def user_history_movies_data(params)
    file_path = "spec/fixtures/trakt/user/history_movies.json"
    if File.file?(file_path)
      File.read(file_path)
    end
  end

  class NotImplementedError < StandardError; end
end
