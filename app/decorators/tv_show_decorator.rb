class TvShowDecorator < Draper::Decorator
  delegate_all

  decorates_association :episodes, with: EpisodeDecorator

  def poster(size = 300)
    if tmdb_poster
      "#{Broad.tmdb_configuration.secure_base_url}w#{size}#{tmdb_poster}"
    else
      murray
    end
  end

  def backdrop
    "#{Broad.tmdb_configuration.secure_base_url}original/#{tmdb_backdrop}"
  end

  def imdb_url
    return '' unless imdb_id.present?
    ::Services::Imdb.new(imdb_id).url
  end

  private

  def tmdb_poster
    tmdb_details.try(:fetch, 'poster_path', nil)
  end

  def tmdb_backdrop
    tmdb_details.try(:fetch, 'backdrop_path', nil)
  end

  def murray
    h.image_url "murray_300x169.jpg"
  end
end
