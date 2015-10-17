class MovieDecorator < Draper::Decorator
  delegate_all

  def poster
    "https://thumbs.picyo.me/200x0/filters:quality(50)/#{omdb_details['poster']}"
  end

  def imdb_url
    Services::Imdb.new(imdb_id).url
  end

  def rt_url
    "http://www.rottentomatoes.com/search/?search=#{title}"
  end

  def rt_icon
    rt_value = omdb_details['tomato_meter'].to_i
    (rt_value == 0 || rt_value >= 60) ? 'rt_fresh.png' : 'rt_rotten.png'
  end

  def best_release
    MovieReleaseDecorator.decorate object.best_release
  end
end
