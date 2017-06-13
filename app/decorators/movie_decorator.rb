class MovieDecorator < Draper::Decorator
  delegate_all

  def poster
    return murray unless tmdb_id.present?
    h.movie_poster_url(tmdb_id, only_path: false)
  end

  def imdb_url
    Services::Imdb.new(imdb_id).url
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
