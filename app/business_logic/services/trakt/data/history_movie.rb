module Services
  module Trakt
    module Data
      class HistoryMovie < Dry::Struct
        transform_keys(&:to_sym)

        attribute :movie, ::Services::Trakt::Data::Movie
        attribute :watched_at, Types::JSON::DateTime.optional
      end
    end
  end
end
