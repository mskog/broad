module Services
  module Trakt
    module Data
      class ProgressSeason < Dry::Struct
        transform_keys(&:to_sym)

        attribute :number, Types::Integer.optional
        attribute :title, Types::String.optional
        attribute :aired, Types::Integer.optional
        attribute :completed, Types::Integer.optional

        attribute :episodes, Types::Array.of(Services::Trakt::Data::ProgressEpisode).optional

        def completed?
          aired == completed
        end
      end
    end
  end
end
