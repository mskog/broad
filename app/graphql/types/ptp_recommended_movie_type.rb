module Types
  class PtpRecommendedMovieType < Types::BaseObject
    field :title, String, null: true
    field :imdb_id, String, null: true
    field :year, Integer, null: true
    field :cover, String, null: true
    field :tags, [String], null: true
    field :imdb_rating, Float, null: true
    field :mc_url, String, null: true
    field :ptp_rating, Integer, null: true
    field :youtube_id, String, null: true
    field :synopsis, String, null: true
  end
end
