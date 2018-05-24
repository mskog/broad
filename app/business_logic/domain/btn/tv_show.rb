module Domain
  module BTN
    class TvShow < SimpleDelegator
      def self.create_from_imdb_id(imdb_id)
        search_result = Services::Search.tv_shows.search(imdb_id).first
        new(::TvShow.find_or_create_by(imdb_id: imdb_id) do |tv_show|
          tv_show.name = search_result.title
          tv_show.tvdb_id = search_result.tvdb_id
        end)
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
