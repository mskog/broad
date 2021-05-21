module Types
  class PtpRecommendedMovieType < Types::BaseObject
    field :title, String, null: false
    field :imdb_id, String, null: false
    field :year, Integer, null: false
    field :cover, String, null: false
    field :tags, [String], null: false
    field :imdb_rating, Float, null: false
    field :mc_url, String, null: true
    field :ptp_rating, Integer, null: false
    field :youtube_id, String, null: false
    field :synopsis, String, null: false
  end
end
