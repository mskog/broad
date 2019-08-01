class FetchNewFeedEntriesJob < ActiveJob::Base
  queue_as :default

  rescue_from(Services::BTN::Feed::BTNIsProbablyDownError) do |exception|
    Rollbar.error(exception)
  end

  def perform
    time = EpisodeRelease.maximum(:published_at) || Time.parse("1970-01-01")
    Services::FetchAndPersistFeedEntries.new(ENV["BTN_FEED_URL"], time).perform
  end
end
