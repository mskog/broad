module Domain
  module BTN
    class TvShow < SimpleDelegator
      def self.create_from_imdb_id(imdb_id)
        search_result = Services::Search.tv_shows(imdb_id).first
        new ::TvShow.create!(name: search_result.title, imdb_id: @imdb_id, tvdb_id: search_result.tvdb_id)
      end

      def sample
        Services::BTN::Api.new.sample(tvdb_id).each do |release|
          episode = Domain::BTN::BuildEpisodeFromEntry.new(self, release).episode
          episode.save
        end
      end
    end
  end
end
