# typed: false
module Services
  module Trakt
    module Data
      class ShowIds < Dry::Struct
        transform_keys(&:to_sym)

        attribute :imdb?, Types::Coercible::String.optional
        attribute :tmdb?, Types::Coercible::Integer.optional
        attribute :trakt?, Types::Coercible::Integer.optional
        attribute :tvdb?, Types::Coercible::Integer.optional
        attribute :tvrage?, Types::Coercible::Integer.optional
        attribute :slug?, Types::Coercible::String.optional
      end
    end
  end
end
