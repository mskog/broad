# typed: strict
module Types
  class MovieReleaseType < Types::BaseObject
    field :id, Integer, null: false
    field :codec, String, null: false
    field :container, String, null: false
    field :quality, String, null: false
    field :release_name, String, null: false
    field :resolution, String, null: false
    field :size, Float, null: false
    field :source, String, null: false

    field :download_url, String, null: true
  end
end
