# typed: true
module Domain
  class AcceptableReleases
    include Enumerable

    def initialize(releases, rule_klass:)
      @releases = releases
      @rule_klass = rule_klass
    end

    def each(&block)
      acceptable_releases.each(&block)
    end

    private

    def acceptable_releases
      @releases.select do |release|
        @rule_klass.new(release).acceptable?
      end
    end
  end
end
