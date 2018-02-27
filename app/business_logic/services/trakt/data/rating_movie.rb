module Services
  module Trakt
    module Data
      class RatingMovie
        include Virtus.model

        attribute :movie, ::Services::Trakt::Data::Movie

        attribute :rated_at, DateTime
        attribute :rating, Integer
      end
    end
  end
end
