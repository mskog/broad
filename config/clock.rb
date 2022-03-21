require 'clockwork'
require './config/boot'
require './config/environment'

# TODO No tests for this. When change is needed here it will not work!
module Clockwork
  error_handler do |error|
    Rollbar.error(error)
  end

  every(15.minutes, 'Downloaded updates from BTN Feed', thread: true, skip_first_run: true) do
    #FetchNewFeedEntriesJob.perform_later
  end

  every(6.hours, 'Sync watched episodes with trakt', thread: true, skip_first_run: true) do
    SyncWatchedEpisodesWithTraktJob.perform_later
  end

  every(6.hours, 'Sync watched movies with trakt', thread: true, skip_first_run: true) do
    SyncWatchedMoviesWithTraktJob.perform_later
  end

  every(6.hours, 'Sync rated movies with trakt', thread: true, skip_first_run: true) do
    SyncRatedMoviesWithTraktJob.perform_later
  end

  every(3.hours, 'Download new releases for waitlist movies', at: '**:15', thread: true, skip_first_run: true) do
    WaitlistMoviesCheckJob.perform_later
  end

  every(12.hours, 'Download better versions of donwloaded movies', at: '**:15', thread: true, skip_first_run: true) do
    CheckForBetterMovieReleasesJob.perform_later
  end

  every(3.hours, 'Download new releases for waitlist tv shows', at: '**:15', thread: true, skip_first_run: true) do
    #WaitlistTvShowsCheckJob.perform_later
  end

  every(1.day, 'Update all waitlist movie details', :at => ["01:00"], thread: true, skip_first_run: true) do
    UpdateAllMovieDetailsJob.perform_later
  end

  every(1.day, 'Fetch TV Show News', :at => ["01:00"], thread: true, skip_first_run: true) do
    FetchTvShowsNewsJob.perform_later
  end

  every(1.day, 'Fetch Movie news', :at => ["01:00"], thread: true, skip_first_run: true) do
    FetchMovieNewsJob.perform_later
  end

  every(1.day, 'Delete old news', :at => ["01:00"], thread: true, skip_first_run: true) do
    DeleteOldNewsItemsJob.perform_later
  end

  every(1.day, 'Update all tv show details', :at => ["01:00"], thread: true, skip_first_run: true) do
    UpdateAllTvShowDetailsJob.perform_later
  end

  every(1.month, "Refresh Trakt token", :if => lambda { |t| t.day == 1 }, thread: true, skip_first_run: true) do
    RefreshTraktTokenJob.perform_later
  end
end
