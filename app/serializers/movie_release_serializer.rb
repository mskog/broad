class MovieReleaseSerializer < ActiveModel::Serializer
  attributes :size, :release_name, :joined_attributes
end
