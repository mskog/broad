module Services

  # TODO specs for movies with releases, but no acceptable ones
  class WaitlistMoviesCheck
    def initialize(movie)
      @movie = Domain::PTP::Movie.new(movie, acceptable_release_rule_klass: Domain::PTP::ReleaseRules::Waitlist)
    end

    def perform
      @movie.fetch_new_releases
      if @movie.has_acceptable_release?
        @movie.download_at = DateTime.now+ENV['PTP_WAITLIST_DELAY_HOURS'].to_i.hours
      end
      @movie.save
    end
  end
end
