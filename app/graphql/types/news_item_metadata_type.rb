# typed: strict
module Types
  class NewsItemMetadataType < Types::BaseObject
    field :image, String, null: true
    field :description, String, null: true
  end
end
