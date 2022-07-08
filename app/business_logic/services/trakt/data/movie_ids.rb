# typed: false
module Services
  module Trakt
    module Data
      class MovieIds < Dry::Struct
        transform_keys(&:to_sym)

        attribute :imdb?, Types::Coercible::String.optional
        attribute :tmdb?, Types::Coercible::Integer.optional
        attribute :trakt?, Types::Coercible::Integer.optional
        attribute :slug?, Types::Coercible::String.optional
      end
    end
  end
end
