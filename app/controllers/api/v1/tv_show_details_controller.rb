class Api::V1::TvShowDetailsController < Api::ApiController
  # caches_action :show, expires_in: 1.hour, cache_path: Proc.new {
  #   api_v1_movie_search_detail_path(params[:id])
  # }


  def show
    details = Services::Trakt::Shows.new.summary(params[:id])
    return unless details.present?
    respond_to do |format|
      format.json {render json: details.to_h.to_json}
    end
  end
end
