# typed: strict
module Types
  class TvShowTmdbDetailsType < Types::BaseObject
    field :original_name, String, null: true
    field :id, Integer, null: true
    field :name, String, null: true
    field :popularity, String, null: true
    field :vote_count, Integer, null: true
    field :vote_average, String, null: true
    field :first_air_date, String, null: true
    field :poster_path, String, null: true
    field :original_language, String, null: true
    field :backdrop_path, String, null: true
    field :overview, String, null: true
    field :origin_country, [String], null: true
    field :genre_ids, [Integer], null: true
  end
end
