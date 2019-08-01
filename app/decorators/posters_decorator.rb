class PostersDecorator < Draper::Decorator
  def url
    if object.key?("posters") && object["posters"].any?
      image = object["posters"][0]["file_path"]
      h.image_url "#{Broad.tmdb_configuration.secure_base_url}original#{image}"
    else
      h.image_url "murray_300x169.jpg"
    end
  end
end
