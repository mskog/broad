class MovieRecommendationsSerializer < ActiveModel::Serializer
  attributes :title, :year, :omdb_details

  has_one :movie_ids, serializer: MovieIdsSerializer
end
