require "sinatra/base"

class FakeTrakt < Sinatra::Base
  get "/search" do
    data = search_data(params)
    content_type :json
    [200, data]
  end

  get "/search/:id_type/:id" do
    data = search_data(params)
    content_type :json
    [200, data]
  end

  get "/calendars/my/shows/premieres*" do
    data = premieres_data(params)
    content_type :json
    [200, data]
  end

  get "/calendars/my/shows*" do
    data = show_calendar_data(params)
    content_type :json
    [200, data]
  end

  get "/recommendations/movies*" do
    data = movie_recommendation_data(params)
    content_type :json
    [200, data]
  end

  delete "/recommendations/movies/:id" do
    204
  end

  get "/users/me/history/shows*" do
    data = user_history_shows_data(params)
    content_type :json
    [200, data]
  end

  get "/users/me/history/movies*" do
    data = user_history_movies_data(params)
    content_type :json
    [200, data]
  end

  get "/movies/:id" do
    data = movie_summary_data(params)
    content_type :json
    status_code = data.present? ? 200 : 404
    [status_code, data]
  end

  get "/sync/ratings/movies" do
    data = ratings_movies_data(params)
    content_type :json
    [200, data]
  end

  get "/shows/:id" do
    data = tv_show_summary_data(params)
    content_type :json
    status_code = data.present? ? 200 : 404
    [status_code, data]
  end

  get "/shows/:id/seasons" do
    data = tv_show_seasons_data(params)
    content_type :json
    status_code = data.present? ? 200 : 404
    [status_code, data]
  end

  get "/*" do
    raise NotImplementedError, "'#{url}' is not implemented in this fake"
  end

  private

  def search_data(params)
    if params.key?("id_type")
      search_data_id(params)
    else
      search_data_query(params)
    end
  end

  def search_data_query(params)
    file_path = "spec/fixtures/trakt/search/#{params['type']}_#{params['query'].tr(' ', '_')}.json".downcase
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

  def movie_summary_data(params)
    file_path = "spec/fixtures/trakt/movies/summary/#{params['id']}.json"
    File.read(file_path) if File.file?(file_path)
  end

  def tv_show_summary_data(params)
    file_path = "spec/fixtures/trakt/shows/summary/#{params['id']}.json"
    File.read(file_path) if File.file?(file_path)
  end

  def tv_show_seasons_data(params)
    file_path = "spec/fixtures/trakt/seasons/summary/#{params['id']}.json"
    File.read(file_path) if File.file?(file_path)
  end

  def show_calendar_data(_params)
    file_path = "spec/fixtures/trakt/calendars/shows.json"
    File.read(file_path) if File.file?(file_path)
  end

  def premieres_data(_params)
    file_path = "spec/fixtures/trakt/calendars/premieres.json"
    File.read(file_path) if File.file?(file_path)
  end

  def movie_recommendation_data(_params)
    file_path = "spec/fixtures/trakt/recommendations/movies.json"
    File.read(file_path) if File.file?(file_path)
  end

  def user_history_shows_data(_params)
    file_path = "spec/fixtures/trakt/user/history_shows.json"
    File.read(file_path) if File.file?(file_path)
  end

  def user_history_movies_data(_params)
    file_path = "spec/fixtures/trakt/user/history_movies.json"
    File.read(file_path) if File.file?(file_path)
  end

  def ratings_movies_data(_params)
    file_path = "spec/fixtures/trakt/user/ratings_movies.json"
    File.read(file_path) if File.file?(file_path)
  end

  class NotImplementedError < StandardError; end
end
