# typed: false
class WaitlistTvShowCheckJob < ActiveJob::Base
  queue_as :btn

  sidekiq_options retry: false

  def perform(tv_show)
    sleep 5 unless Rails.env.test?
    tv_show.sample
  end
end
