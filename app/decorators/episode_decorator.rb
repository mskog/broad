class EpisodeDecorator < Draper::Decorator
  delegate_all

  def season_episode
    "S#{season.to_s.rjust(2,'0')}E#{episode.to_s.rjust(2, '0')}"
  end

  def still(size = 300)
    still_path = tmdb_details['still_path']
    if still_path
      "#{Broad.tmdb_configuration.secure_base_url}w#{size}#{still_path}"
    else
      h.image_url "murray_300x169.jpg"
    end
  end

  # TODO No good!
  def episode
    object.episode
  end
end
