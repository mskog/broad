class CheckForBetterMovieReleasesJob < ActiveJob::Base
  queue_as :ptp

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      Movie
        .where.not(id: MovieRelease.where(resolution: "2160p", downloaded: true).select(:movie_id))
        .where(watched: false)
        .where("download_at >= ?", 1.month.ago)
        .each do |movie|
        domain_movie = Domain::PTP::Movie.new(movie)
        domain_movie.fetch_new_releases
        domain_movie.update(download_at: DateTime.now) if domain_movie.has_better_release_than_downloaded?
        sleep 5 unless Rails.env.test?
      end
    end
  end
end
