class Api::V1::MovieSearchDetailsController < Api::ApiController
  # caches_action :show, expires_in: 1.hour, cache_path: Proc.new {
  #   api_v1_movie_search_detail_path(params[:id])
  # }


  def show
    omdb_movie = Omdb::Api.new.find(params[:id], true)[:movie]
    return unless omdb_movie.present?
    data = omdb_movie.public_methods(false).each_with_object({}) do |method, object|
      object[method] = omdb_movie.public_send(method)
    end
    respond_to do |format|
      format.json {render json: data.to_json}
    end
  end
end
