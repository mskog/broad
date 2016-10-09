class MoviePostersDecorator < Draper::Decorator
  def url
    if source.key?('posters') && source['posters'].any?
      image = source['posters'][0]['file_path']
      h.thumbor_image_url "#{Broad.tmdb_configuration.secure_base_url}w#{300}#{image}"
    else
      h.image_url "murray_300x169.jpg"
    end
  end
end
