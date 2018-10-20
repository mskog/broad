module Services
  class WaitlistMoviesCheck
    def initialize(movie, ptp_api: Services::PTP::Api.new)
      @movie = Domain::PTP::Movie.new(
        movie,
        ptp_api: ptp_api,
        acceptable_release_rule_klass: Domain::PTP::ReleaseRules::Waitlist
      )
    end

    def perform
      @movie.fetch_new_releases
      if @movie.has_acceptable_release?
        notify_huginn
        set_download_at
      end
      @movie.save
    end

    private

    def set_download_at
      if @movie.has_killer_release?
        set_killer_release
      else
        set_delayed_download_at
      end
    end

    def notify_huginn
      return unless @movie.title.present?
      return if @movie.download_at.present? && (!@movie.has_killer_release? && @movie.download_at < movie_download_time)
      if @movie.has_killer_release?
        message = "A killer release for #{@movie.title} has been found. Will download immediately"
      else
        hours = ENV['PTP_WAITLIST_DELAY_HOURS']
        message = "An acceptable release for #{@movie.title} has been found. Will download in #{hours} hours"
      end
      NotifyHuginnJob.perform_later message
    end

    def set_killer_release
      @movie.download_at = [@movie.download_at, DateTime.now].compact.min
    end

    def set_delayed_download_at
      if !@movie.download_at.present?
        @movie.download_at = movie_download_time
      end
    end

    def movie_download_time
      DateTime.now+ENV['PTP_WAITLIST_DELAY_HOURS'].to_i.hours
    end
  end
end
