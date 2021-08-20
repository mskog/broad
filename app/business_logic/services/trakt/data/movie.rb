module Services
  module Trakt
    module Data
      class Movie < Dry::Struct
        transform_keys(&:to_sym)

        attribute :ids, MovieIds.optional

        attribute :title, Types::String.optional
        attribute :year, Types::Integer.optional
      end
    end
  end
end
