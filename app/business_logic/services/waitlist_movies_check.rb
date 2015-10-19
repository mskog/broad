module Services
  class WaitlistMoviesCheck
    def initialize(movie, ptp_api: Services::PTP::Api.new)
      @movie = Domain::PTP::Movie.new(movie, ptp_api: ptp_api, acceptable_release_rule_klass: Domain::PTP::ReleaseRules::Waitlist)
    end

    def perform
      @movie.fetch_new_releases
      if @movie.has_acceptable_release?
        set_download_at
      end
      @movie.save
    end

    private

    def set_download_at
      if has_killer_release?
        set_killer_release
      else
        set_delayed_download_at
      end
    end

    def has_killer_release?
      @movie.best_release.version_attributes.include?('remux')
    end

    def set_killer_release
      @movie.download_at = [@movie.download_at, DateTime.now].compact.min
    end

    def set_delayed_download_at
      if !@movie.download_at.present?
        @movie.download_at = DateTime.now+ENV['PTP_WAITLIST_DELAY_HOURS'].to_i.hours
      end
    end
  end
end
