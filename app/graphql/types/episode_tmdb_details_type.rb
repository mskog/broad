# typed: strict
module Types
  class EpisodeTmdbDetailsType < Types::BaseObject
    field :first_air_date, String, null: true
    field :episode_number, Integer, null: true
    field :season_number, Integer, null: true
    field :name, String, null: true
    field :overview, String, null: true
    field :id, Integer, null: true
    field :still_path, String, null: true
    field :vote_average, String, null: true
    field :vote_count, Integer, null: true
  end
end
