# typed: strict

class Posters
  extend T::Sig

  # TODO: Add better types
  sig{params(tmdb_images: T.untyped).void}
  def initialize(tmdb_images)
    @tmdb_images = tmdb_images
  end

  sig{returns(String)}
  def url
    if @tmdb_images.key?("posters") && @tmdb_images["posters"].any?
      image = @tmdb_images["posters"][0]["file_path"]
      ActionController::Base.helpers.image_url "#{Broad.tmdb_configuration.secure_base_url}w1280#{image}"
    else
      ""
    end
  end
end
