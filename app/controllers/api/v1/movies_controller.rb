class Api::V1::MoviesController < Api::ApiController
  CATEGORIES = {
    "watched" => :watched,
    "waitlist" => :on_waitlist,
    "downloads" => :downloadable
  }.freeze

  def index
    category = CATEGORIES.fetch(params[:category].to_s, :all)
    @view = ViewObjects::Movies.public_send(category).paginate(page: params.fetch(:page, 1), per_page: params.fetch(:per_page, 20))
    json = Rails.cache.fetch(@view.cache_key) do
      @view.to_json
    end

    respond_to do |format|
      format.json {render json: json}
    end
  end
end
