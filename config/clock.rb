require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  error_handler do |error|
    Rollbar.error(error)
  end

  every(1.hour, 'Downloaded updates from BTN Feed', :at => '**:30', thread: true) do
    time = EpisodeRelease.maximum(:published_at) || Time.parse('1970-01-01')
    Services::FetchAndPersistFeedEntries.new(ENV['BTN_FEED_URL'], time).perform
  end

  every(12.hour, 'Download new releases for Overwatch movies', :at => ["08:00", "22:00"], thread: true) do
    Movie.on_overwatch.each do |movie|
      Services::FetchNewMovieReleases.new(movie).perform
      sleep 5 unless Rails.env.test?
    end
  end
end
