class SearchesController < ApplicationController
  def show
    @component = params[:search_type].presence == "tv_shows" ? "TvShowSearch" : "MovieSearch"
  end
end
