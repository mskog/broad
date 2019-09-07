class EpisodeSerializer < ActiveModel::Serializer
  attributes(*Episode.attribute_names, :still)
end
