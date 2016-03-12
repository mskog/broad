class Api::V1::MovieAcceptableReleasesController < Api::ApiController
  def show
    movie = Movie.new(imdb_id: params[:id])
    @view = MovieDecorator.decorate Domain::PTP::Movie.new(movie)
    @view.fetch_new_releases
    render json: @view, serializer: MovieAcceptableReleasesSerializer
  end
end
