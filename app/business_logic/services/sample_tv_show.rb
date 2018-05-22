module Services
  class SampleTvShow
    def initialize(imdb_id)
      @imdb_id = imdb_id
    end

    def perform
      create_tv_show
      download_sample
    end

    private

    def create_tv_show
      search_results = Services::TvShowSearch.new(@imdb_id)
      @tv_show = TvShow.create!(name: search_results.first.title, imdb_id: @imdb_id)
      @tvdb_id = search_results.first.tvdb_id
    end

    def download_sample
      Services::BTN::Api.new.sample(@tvdb_id).each do |release|
        episode = Domain::BTN::BuildEpisodeFromEntry.new(@tv_show, release).episode
        episode.save
      end
    end
  end
end