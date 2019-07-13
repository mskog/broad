class TvShowSerializer < ActiveModel::Serializer
  attributes *TvShow.attribute_names

  has_many :episodes, serializer: EpisodeSerializer
end
