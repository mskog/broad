class Posters
  include Routeable

  def initialize(tmdb_images)
    @tmdb_images = tmdb_images
  end

  def url
    if object.key?("posters") && object["posters"].any?
      image = object["posters"][0]["file_path"]
      image_url "#{Broad.tmdb_configuration.secure_base_url}w1280#{image}"
    else
      image_url "murray_300x169.jpg"
    end
  end
end
