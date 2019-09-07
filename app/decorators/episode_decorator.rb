# TODO: Should this be split into WithDetails and Without? Lots of if-statements for it?
class EpisodeDecorator < Draper::Decorator
  delegate_all

  def season_episode
    "S#{season.to_s.rjust(2, '0')}E#{episode.to_s.rjust(2, '0')}"
  end

  def still
    if tmdb_still
      "#{Broad.tmdb_configuration.secure_base_url}original#{tmdb_still}"
    else
      murray
    end
  end

  # TODO: No good!
  def episode
    object.episode
  end

  def best_release
    EpisodeReleaseDecorator.decorate object.best_release
  end

  private

  # TODO: Eww
  def tmdb_still
    tmdb_details.try(:fetch, "still_path", nil) || tv_show.tmdb_details.try(:fetch, "backdrop_path", nil)
  end

  def murray
    h.image_url "murray_300x169.jpg"
  end
end
