module Services
  module Trakt
    module Data
      class MovieExtended < Movie
        attribute :tagline, String
        attribute :overview, String
        attribute :released, Date
        attribute :runtime, Integer
        attribute :trailer, String
        attribute :homepage, String
        attribute :rating, Float
        attribute :votes, Integer
        attribute :updated_at, DateTime
        attribute :language, String
        attribute :genres, Array
        attribute :certification, String
      end
    end
  end
end
