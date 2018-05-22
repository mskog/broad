class TvShowsController < ApplicationController
  skip_before_action :verify_authenticity_token


  def sample
    Services::SampleTvShow.new(params[:imdb_id]).perform
    redirect_to episodes_path
  end
end
