class TvShowsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @view = TvShowDecorator.decorate_collection(ViewObjects::TvShows
            .from_params(params))
  end

  def show
    @view = TvShowDecorator.decorate ViewObjects::TvShow.from_params(params)
  end

  # TODO Existing tv shows?
  def sample
    Domain::BTN::TvShow
      .create_from_imdb_id(params[:imdb_id])
      .sample
    redirect_to episodes_path
  end

  def watching
    domain_show
      .watch
    redirect_to tv_show_path(domain_show)
  end

  def not_watching
    domain_show
      .unwatch
    redirect_to tv_show_path(domain_show)
  end

  def collect
    tv_show.update(collected: true, watching: true)

    # Wait for an hour to make sure the details have been downloaded
    CollectTvShowJob.set(wait: 1.hour).perform_later(tv_show)
    redirect_to tv_show_path(tv_show)
  end

  private

  def domain_show
    @domain_show ||= Domain::BTN::TvShow.new(tv_show)
  end

  def tv_show
    TvShow.find(params[:id])
  end
end
