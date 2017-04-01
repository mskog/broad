require 'clockwork'
require './config/boot'
require './config/environment'

# TODO No tests for this. When change is needed here it will not work!
module Clockwork
  error_handler do |error|
    Rollbar.error(error)
  end

  every(1.hour, 'Downloaded updates from BTN Feed', :at => '**:30', thread: true) do
    FetchNewFeedEntriesJob.perform_later
  end

  every(1.hour, 'Download updates from Movie Recommendations', :at => '**:30', thread: true) do
    FetchMovieRecommendationsJob.perform_later
  end

  every(6.hours, 'Sync watched episodes with trakt', thread: true) do
    SyncWatchedEpisodesWithTraktJob.perform_later
  end

  every(6.hours, 'Sync watched movies with trakt', thread: true) do
    SyncWatchedMoviesWithTraktJob.perform_later
  end

  every(3.hours, 'Download new releases for waitlist movies', at: '**:15', thread: true) do
    WaitlistMoviesCheckJob.perform_later
  end

  every(1.day, 'Update all waitlist movie details', :at => ["01:00"], thread: true) do
    UpdateAllMovieDetailsJob.perform_later
  end

  every(1.day, 'Update all tv show details', :at => ["01:00"], thread: true) do
    UpdateAllTvShowDetailsJob.perform_later
  end

  every(1.month, "Refresh Trakt token", :if => lambda { |t| t.day == 1 }, thread: true) do
    RefreshTraktTokenJob.perform_later
  end
end
