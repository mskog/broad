class EpisodeSerializer < ActiveModel::Serializer
  attributes(*Episode.attribute_names, :still)

  def still
    object.still(500)
  end
end
