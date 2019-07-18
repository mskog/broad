class TvShowSerializer < ActiveModel::Serializer
  attributes *TvShow.attribute_names

  has_many :released_episodes, serializer: EpisodeSerializer
end
