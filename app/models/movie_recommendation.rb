class MovieRecommendation < ActiveRecord::Base
  validates_presence_of :title
  validates_uniqueness_of :imdb_id, allow_nil: true
  validates_uniqueness_of :trakt_id, allow_nil: true
  validates_uniqueness_of :tmdb_id, allow_nil: true
end
