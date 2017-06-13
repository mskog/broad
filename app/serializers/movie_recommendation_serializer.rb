class MovieRecommendationsSerializer < ActiveModel::Serializer
  attributes :title, :year

  has_one :movie_ids, serializer: MovieIdsSerializer
end
