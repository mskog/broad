# typed: false
class UpdateAllTvShowDetailsJob < ActiveJob::Base
  queue_as :default

  def perform
    TvShow.find_each do |tv_show|
      FetchTvShowDetailsTmdbJob.perform_later tv_show
      FetchTvShowDetailsTraktJob.perform_later tv_show
    end
  end
end
