module Services

  # TODO specs for movies with releases, but no acceptable ones
  class OverwatchMoviesCheck
    def initialize(movie)
      @movie = Domain::PTP::Movie.new(movie)
    end

    def perform
      @movie.fetch_new_releases
      if @movie.has_acceptable_release?
        @movie.download_at = DateTime.now+ENV['PTP_OVERWATCH_DELAY_HOURS'].to_i.hours
        @movie.save
      end
    end
  end
end
