module Services
  module Trakt
    module Data
      class ProgressShow < Dry::Struct
        transform_keys(&:to_sym)

        attribute :aired, Types::Integer.optional
        attribute :completed, Types::Integer.optional
        attribute :last_collected_at, Types::JSON::DateTime.optional
        attribute :seasons, Types::Array.of(Services::Trakt::Data::ProgressSeason).optional

        def completed?
          aired == completed
        end
      end
    end
  end
end
