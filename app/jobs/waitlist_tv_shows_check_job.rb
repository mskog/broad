# TODO: Specs
class WaitlistTvShowsCheckJob < ActiveJob::Base
  queue_as :default

  def perform
    TvShow.on_waitlist.each do |tv_show|
      WaitlistTvShowCheckJob.perform_later tv_show
    end
  end
end
