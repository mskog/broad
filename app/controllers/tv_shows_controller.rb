class TvShowsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @view = TvShowDecorator.decorate_collection(ViewObjects::TvShows
            .from_params(params))
  end

  def show
    @view = TvShowDecorator.decorate ViewObjects::TvShow.from_params(params)
  end

  # TODO: Existing tv shows?
  def sample
    domain_show
      .sample
    redirect_to tv_show_path(tv_show.id)
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
    redirect_to tv_show_path(tv_show.id)
  end

  private

  def domain_show
    @domain_show ||= Domain::BTN::TvShow.new(tv_show)
  end

  def tv_show
    if params.key?(:id)
      TvShow.find(params[:id])
    else
      Domain::BTN::TvShow.create_from_imdb_id(params[:imdb_id]).__getobj__
    end
  end
end
