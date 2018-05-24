class MovieSearchResultDecorator < Draper::Decorator
  delegate_all

  def poster
    movie_poster = object.poster
    if movie_poster.present?
      movie_poster
    else
      h.image_url("murray.jpg")
    end
  end

  def rt_url
    "http://www.rottentomatoes.com/search/?search=#{title}"
  end
end
