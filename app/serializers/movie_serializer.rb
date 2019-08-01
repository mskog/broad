class MovieSerializer < ActiveModel::Serializer
  attributes(*Movie.attribute_names, :best_release)

  has_one :best_release, serializer: MovieReleaseSerializer
end
