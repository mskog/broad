class WaitlistTvShowCheckJob < ActiveJob::Base
  queue_as :ptp

  def perform(tv_show)
    Domain::BTN::TvShow.new(tv_show).sample
    sleep 5 unless Rails.env.test?
  end
end
