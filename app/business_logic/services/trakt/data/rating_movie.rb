module Services
  module Trakt
    module Data
      class RatingMovie < Dry::Struct
        transform_keys(&:to_sym)

        attribute :movie, ::Services::Trakt::Data::Movie

        attribute :rated_at, Types::JSON::DateTime
        attribute :rating, Types::Integer
      end
    end
  end
end
