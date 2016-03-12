class MovieAcceptableReleasesSerializer < ActiveModel::Serializer
  attributes :imdb_id, :has_killer_release?, :has_acceptable_release?

  has_one :best_release, serializer: MovieReleaseSerializer
end
