module ViewObjects
  class Movies
    include Enumerable

    def self.on_waitlist
      new(Movie.on_waitlist.order("download_at IS NOT NULL desc, download_at asc, movies.id desc"), cache_prefix: 'waitlist')
    end

    def self.downloadable
      new(Movie.downloadable.order(id: :desc), cache_prefix: 'downloadable')
    end

    def initialize(scope, acceptable_release_rule_klass: Domain::PTP::ReleaseRules::Waitlist, cache_prefix: nil)
      @scope = scope
      @acceptable_release_rule_klass = acceptable_release_rule_klass
      @cache_prefix = cache_prefix
    end

    def each(&block)
      ptp_service = Services::PTP::Api.new
      movies.each do |movie|
        yield Domain::PTP::Movie.new(movie, ptp_api: ptp_service, acceptable_release_rule_klass: @acceptable_release_rule_klass)
      end
    end

    def cache_key
      ['viewobjects', 'movies', @cache_prefix, @scope.maximum(:updated_at).to_i].compact.join('-')
    end

    private

    def movies
      @movies ||= @scope
    end
  end
end
