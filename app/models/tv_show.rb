class TvShow < ActiveRecord::Base
  after_commit :fetch_details, :on => :create

  has_many :episodes

  private

  def fetch_details
    FetchTvShowDetailsJob.perform_later self
  end
end
