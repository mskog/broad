class TvShow < ActiveRecord::Base
  serialize :tmdb_details
  serialize :trakt_details, Hash

  after_commit :fetch_details, :on => :create

  has_many :episodes, dependent: :destroy

  private

  def fetch_details
    FetchTvShowDetailsJob.perform_later self
    FetchTvShowDetailsTraktJob.perform_later self
  end
end
