module Services
  module Trakt
    module Data
      class MovieIds
        include Virtus.model

        attribute :imdb
        attribute :tmdb
        attribute :trakt
        attribute :slug
      end
    end
  end
end
