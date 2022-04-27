module Services
  module Trakt
    module Data
      class ProgressEpisode < Dry::Struct
        transform_keys(&:to_sym)

        attribute :number, Types::Integer.optional
        attribute :completed, Types::Bool.optional
        attribute :collected_at, Types::JSON::DateTime.optional

        def completed?
          completed == true
        end
      end
    end
  end
end
