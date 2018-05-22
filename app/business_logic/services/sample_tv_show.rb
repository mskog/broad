module Services
  class SampleTvShow
    def initialize(imdb_id)
      @imdb_id = imdb_id
    end

    def perform
      Domain::BTN::TvShow.create_from_imdb_id(@imdb_id).sample
    end
  end
end