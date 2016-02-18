class MoviesDecorator < Draper::CollectionDecorator
  delegate :cache_key
end
