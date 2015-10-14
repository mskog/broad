class MovieSearchResultDecorator < Draper::Decorator
  delegate_all

  def poster
    movie_poster = object.poster
    if movie_poster != 'N/A'
      "https://thumbs.picyo.me/200x0/filters:quality(50)/#{movie_poster}"
    else
      "http://www.fillmurray.com/300/444"
    end
  end

  def imdb_url
    Services::Imdb.new(imdb_id).url
  end

  def rt_url
    "http://www.rottentomatoes.com/search/?search=#{title}"
  end
end
