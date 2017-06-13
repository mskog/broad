class MovieDecorator < Draper::Decorator
  delegate_all

  def poster
    return murray unless tmdb_id.present?
    h.movie_poster_url(tmdb_id, only_path: false)
  end

  def imdb_url
    Services::Imdb.new(imdb_id).url
  end

  def release_date_year
    release_date.try(:year) || "-"
  end

  def genres
    return "-" unless object.genres.present?
    object.genres.map(&:capitalize).join(", ")
  end

  def runtime
    return "-" unless object.runtime.present?
    "#{object.runtime / 60}h #{object.runtime % 60}m"
  end

  def watched_at
    return "-" unless object.watched_at.present?
    object.watched_at.to_date.to_s
  end

  def best_release
    return nil unless object.best_release.present?
    MovieReleaseDecorator.decorate object.best_release
  end

  def forcable?
    waitlist? && download_at.present? && download_at >= Time.now
  end

  private

  def murray
    h.image_url "murray_200x307.jpg"
  end
end
