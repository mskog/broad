class MovieRecommendation < ActiveRecord::Base
  validates_presence_of :title
  validates_uniqueness_of :imdb_id, allow_nil: true
  validates_uniqueness_of :trakt_id, allow_nil: true
  validates_uniqueness_of :tmdb_id, allow_nil: true

  after_commit :fetch_details, :on => :create

  def fetch_details
    FetchMovieDetailsJob.perform_later self
  end
end
