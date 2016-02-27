module Services
  module Trakt
    module Data
      class Movie
        include Virtus.model

        attribute :ids, MovieIds

        attribute :title
        attribute :year
      end
    end
  end
end
