module Services
  class WaitlistMoviesCheck
    def initialize(movie, ptp_api: Services::PTP::Api.new)
      @movie = Domain::PTP::Movie.new(movie, ptp_api: ptp_api, acceptable_release_rule_klass: Domain::PTP::ReleaseRules::Waitlist)
    end

    def perform
      @movie.fetch_new_releases
      if !@movie.download_at.present? && @movie.has_acceptable_release?
        @movie.download_at = DateTime.now+ENV['PTP_WAITLIST_DELAY_HOURS'].to_i.hours
      end
      @movie.save
    end
  end
end
