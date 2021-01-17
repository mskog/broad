class MovieIdsSerializer < ActiveModel::Serializer
  attributes :imdb, :slug, :trakt, :tmdb
end
