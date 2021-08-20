module Services
  module Trakt
    module Data
      class ShowExtended < Dry::Struct
        transform_keys(&:to_sym)

        attribute :ids, ShowIds.optional

        attribute :title, Types::String.optional
        attribute :year, Types::Integer.optional

        attribute :overview, Types::String.optional
        attribute :first_aired, Types::JSON::Date.optional
        attribute :trailer, Types::String.optional
        attribute :homepage, Types::String.optional
        attribute :rating, Types::Float.optional
        attribute :runtime, Types::Integer.optional
        attribute :votes, Types::Integer.optional
        attribute :updated_at, Types::JSON::DateTime.optional
        attribute :language, Types::String.optional
        attribute :genres, Types::Array.of(Types::String).optional
        attribute :certification, Types::String.optional

        attribute :country, Types::String.optional
        attribute :network, Types::String.optional

        attribute :status, Types::String.optional
        attribute :aired_episodes, Types::Integer.optional
      end
    end
  end
end
