# TODO: This is not specific to search. Remove Search from name
# TODO This is using a service called MovieDetails. Doesn't seem necessary
# TODO Lacks specs
class Api::V1::MovieSearchDetailsController < Api::ApiController
  # caches_action :show, expires_in: 1.hour, cache_path: Proc.new {
  #   api_v1_movie_search_detail_path(params[:id])
  # }

  def show
    movie_details = Services::MovieDetails.from_trakt(Services::Trakt::Movies.new.summary(params[:id]))
    return unless movie_details.present?
    respond_to do |format|
      format.json{render json: movie_details.to_h.to_json}
    end
  end
end
