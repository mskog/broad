module Services

  # TODO specs for movies with releases, but no acceptable ones
  # TODO specs for which movies to check
  # TODO Preek smells
  class OverwatchMoviesCheck
    def perform
      movies.each do |movie|
        fetch_new_releases(movie)

        if Domain::PTP::Movie.new(movie).has_acceptable_release?
          movie.download_at = DateTime.now+ENV['PTP_OVERWATCH_DELAY_HOURS'].to_i.hours
          movie.save
        end
      end
    end

    private

    def fetch_new_releases(movie)
      Services::FetchNewMovieReleases.new(movie).perform
    end

    def movies
      Movie.all
    end
  end
end
