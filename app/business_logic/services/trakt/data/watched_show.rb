module Services
  module Trakt
    module Data
      class WatchedShow < Dry::Struct
        transform_keys(&:to_sym)

        attribute :aired, Types::Integer.optional
        attribute :completed, Types::Integer.optional
        attribute :last_watched_at, Types::JSON::DateTime.optional
        attribute :seasons, Types::Array.of(Services::Trakt::Data::WatchedSeason).optional

        def completed?
          aired == completed
        end
      end
    end
  end
end
