module Services
  module Trakt
    module Data
      class WatchedEpisode < Dry::Struct
        transform_keys(&:to_sym)

        attribute :number, Types::Integer.optional
        attribute :completed, Types::Bool.optional
        attribute :last_watched_at, Types::JSON::DateTime.optional

        def completed?
          completed == true
        end
      end
    end
  end
end
