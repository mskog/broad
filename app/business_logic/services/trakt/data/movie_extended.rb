# typed: false
module Services
  module Trakt
    module Data
      class MovieExtended < Services::Trakt::Data::Movie
        transform_keys(&:to_sym)

        attribute :tagline, Types::String.optional
        attribute :overview, Types::String.optional
        attribute :released, Types::JSON::Date.optional
        attribute :runtime, Types::Integer.optional
        attribute :trailer, Types::String.optional
        attribute :homepage, Types::String.optional
        attribute :rating, Types::Float.optional
        attribute :votes, Types::Integer.optional
        attribute :updated_at, Types::JSON::DateTime.optional
        attribute :language, Types::String.optional
        attribute :genres, Types::Array.of(Types::String).optional
        attribute :certification, Types::String.optional
        attribute :status?, Types::String.optional
      end
    end
  end
end
