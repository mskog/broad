module Services
  module Trakt
    module Data
      class Show < Dry::Struct
        transform_keys(&:to_sym)

        attribute :ids, ShowIds.optional

        attribute :title, Types::String.optional
        attribute :year, Types::Integer.optional
      end
    end
  end
end
