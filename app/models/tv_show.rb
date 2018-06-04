class TvShow < ActiveRecord::Base
  serialize :tmdb_details, Hash
  serialize :trakt_details, Hash

  after_commit :fetch_details, :on => :create

  has_many :episodes, dependent: :destroy

  scope :watching, -> {where(watching: true)}
  scope :not_watching, -> {where(watching: false)}


  private

  def fetch_details
    FetchTvShowDetailsTmdbJob.perform_later self
    FetchTvShowDetailsTraktJob.perform_later self
  end
end
