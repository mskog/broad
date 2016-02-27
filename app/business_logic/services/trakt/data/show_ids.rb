module Services
  module Trakt
    module Data
      class ShowIds
        include Virtus.model

        attribute :imdb
        attribute :tmdb
        attribute :trakt
        attribute :tvdb
        attribute :tvrage
        attribute :slug
      end
    end
  end
end
