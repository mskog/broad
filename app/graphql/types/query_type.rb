# typed: ignore
module Types
  class QueryType < Types::BaseObject
    field :movies,
          resolver: Resolvers::Movies,
          null: false,
          description: "Returns a list of Movies"

    field :bestMovies,
          resolver: Resolvers::BestMovies,
          null: false,
          description: "Returns a list of the best watched movies given a year"

    field :movie,
          Types::MovieType,
          null: false,
          description: "Returns a single movie" do
            argument :id, ID, required: true
          end

    field :movie_poster,
          Types::MoviePosterType,
          null: false,
          description: "Returns a poster for a movie" do
            argument :tmdb_id, ID, required: true
          end

    field :movie_summary,
          Types::MovieSummaryType,
          null: false,
          description: "Returns a Trakt summary for a movie based on IMDB id" do
            argument :imdb_id, ID, required: true
          end

    field :tv_show_poster,
          Types::TvShowPosterType,
          null: false,
          description: "Returns a poster for a tv show" do
            argument :tmdb_id, ID, required: true
          end

    field :tv_shows,
          resolver: Resolvers::TvShows,
          null: false,
          description: "Returns a list of TV Shows"

    field :tv_show,
          Types::TvShowType,
          null: false,
          description: "Returns a single tv show" do
            argument :id, ID, required: true
          end

    field :tv_show_summary,
          Types::TvShowSummaryType,
          null: false,
          description: "Returns a Trakt summary for a tv show based on IMDB id" do
            argument :imdb_id, ID, required: true
          end

    field :episode,
          Types::EpisodeType,
          null: false,
          description: "Returns a single tv show" do
            argument :id, ID, required: true
          end

    field :episodes,
          resolver: Resolvers::Episodes,
          null: false,
          description: "Returns a list of Episode"

    field :movie_search,
          [Types::MovieSearchType],
          null: false,
          description: "Searches for a movie" do
            argument :query, String, required: true
          end

    field :tv_show_search,
          [Types::TvShowSearchType],
          null: false,
          description: "Searches for a tv show" do
            argument :query, String, required: true
          end

    field :movie_search_result,
          Types::MovieSearchType,
          null: false,
          description: "Gets the detailed search result for a movie" do
            argument :imdb_id, String, required: true
          end

    field :tv_show_search_result,
          Types::TvShowSearchType,
          null: false,
          description: "Gets the detailed search result for a tv show" do
            argument :imdb_id, String, required: true
          end

    field :tv_show_details,
          Types::TvShowDetailsType,
          null: false,
          description: "Gets the summary details for a tv show" do
            argument :imdb_id, String, required: true
          end

    field :tv_shows_calendar,
          [Types::CalendarEpisodeType],
          null: false,
          description: "Calendar of TV Show releases"

    field :calendar,
          resolver: Resolvers::Calendar,
          null: false,
          description: "Calendar of TV Show and Movie releases"

    field :omnisearch,
          resolver: Resolvers::Omnisearch,
          null: false,
          description: "Search for any content"

    field :news,
          resolver: Resolvers::News,
          null: false

    field :show_collection_progress,
          resolver: Resolvers::ShowCollectionProgress,
          null: false

    field :ptp_movie_recommendations,
          resolver: Resolvers::PtpMovieRecommendations,
          null: false

    def movie(id:)
      Movie.includes(:releases).find(id)
    end

    def tv_show(id:)
      TvShow.find(id)
    end

    def movie_poster(tmdb_id:)
      tmdb_images = Rails.cache.fetch("tmdb_poster_images_movie_#{tmdb_id}") do
        Tmdb::Movie.images(tmdb_id)
      end

      images = Posters.new tmdb_images
      {url: images.url}
    end

    def movie_summary(imdb_id:)
      Services::Trakt::Movies.new.summary(imdb_id)
    end

    def tv_show_poster(tmdb_id:)
      tmdb_images = Rails.cache.fetch("tmdb_poster_images_tv_show_#{tmdb_id}") do
        Tmdb::TV.images(tmdb_id)
      end

      images = Posters.new tmdb_images
      {url: images.url}
    end

    def tv_show_summary(imdb_id:)
      Services::Trakt::Shows.new.summary(imdb_id)
    end

    def episode(id:)
      ::Episode.find(id)
    end

    # TODO: Move the imdb_id-filter to the search objects
    def movie_search(query:)
      ViewObjects::Search.movies(query).select{|movie| movie.imdb_id.present? && movie.year.present?}.sort_by(&:year).reverse
    end

    def tv_show_search(query:)
      ViewObjects::Search.tv_shows(query).select{|tv_show| tv_show.imdb_id.present? && tv_show.year.present?}.sort_by(&:year).reverse
    end

    def movie_search_result(imdb_id:)
      ViewObjects::Search.movies(imdb_id).first
    end

    def tv_show_search_result(imdb_id:)
      ViewObjects::Search.tv_shows(imdb_id).first
    end

    def tv_show_details(imdb_id:)
      Services::Trakt::Shows.new.summary(imdb_id)
    end

    def tv_shows_calendar
      ViewObjects::TvShowsCalendar.new(cache_key_prefix: "watching").watching.episodes
    end
  end
end
