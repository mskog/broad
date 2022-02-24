module ViewObjects
  class Movies
    include Enumerable
    include ViewObjects::Support::Paginatable

    delegate :current_page, :total_pages, :limit_value, :total_count,
             :entry_name, :offset_value, :last_page?, to: :movies

    def self.all
      new(Movie.includes(:releases).order(Arel.sql("download_at IS NOT NULL desc, download_at desc, movies.id desc")))
    end

    def self.on_waitlist
      new(Movie.on_waitlist.includes(:releases).order(Arel.sql("download_at IS NOT NULL desc, download_at desc, movies.id desc")))
    end

    def self.watched
      new(Movie.watched.order("movies.watched_at DESC"))
    end

    def initialize(scope)
      @scope = scope
    end

    def each(&block)
      movies.each(&block)
    end

    private

    def movies
      @movies ||= @scope
    end
  end
end
