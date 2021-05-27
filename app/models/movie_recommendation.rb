class MovieRecommendation < ApplicationRecord
  validates :title, presence: true
  validates :imdb_id, uniqueness: { allow_nil: true }
  validates :trakt_id, uniqueness: { allow_nil: true }
  validates :tmdb_id, uniqueness: { allow_nil: true }

  after_commit :fetch_details, :on => :create

  def fetch_details
    FetchMovieDetailsJob.perform_later self
  end
end
