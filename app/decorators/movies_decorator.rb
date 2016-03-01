class MoviesDecorator < PaginatingDecorator
  delegate :cache_key
end
