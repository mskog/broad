module Types
  class EpisodeReleaseType < Types::BaseObject
    field :id, Integer, null: false
    field :resolution, String, null: false
  end
end
