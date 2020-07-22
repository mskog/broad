module Types
  class MutationType < Types::BaseObject
    field :add_movie_to_waitlist, mutation: Mutations::AddMovieToWaitlist
    field :download_movie, mutation: Mutations::DownloadMovie
    field :force_movie_download, mutation: Mutations::ForceMovieDownload
    field :delete_movie, mutation: Mutations::DeleteMovie
    field :rate_movie, mutation: Mutations::RateMovie

    field :unwatch_tv_show, mutation: Mutations::UnwatchTvShow
    field :watch_tv_show, mutation: Mutations::WatchTvShow
    field :collect_tv_show, mutation: Mutations::CollectTvShow
    field :sample_tv_show, mutation: Mutations::SampleTvShow

    field :episode_watched, mutation: Mutations::EpisodeWatched
  end
end
