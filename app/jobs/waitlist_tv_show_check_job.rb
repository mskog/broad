class WaitlistTvShowCheckJob < ActiveJob::Base
  queue_as :ptp

  sidekiq_options retry: false

  def perform(tv_show)
    Domain::Btn::TvShow.new(tv_show).sample
    sleep 5 unless Rails.env.test?
  end
end
