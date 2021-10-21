class Posters
  def initialize(tmdb_images)
    @tmdb_images = tmdb_images
  end

  def url
    if @tmdb_images.key?("posters") && @tmdb_images["posters"].any?
      image = @tmdb_images["posters"][0]["file_path"]
      ActionController::Base.helpers.image_url "#{Broad.tmdb_configuration.secure_base_url}w1280#{image}"
    else
      ""
    end
  end
end
