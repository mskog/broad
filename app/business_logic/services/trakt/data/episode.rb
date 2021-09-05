module Services
  module Trakt
    module Data
      class Episode < Dry::Struct
        transform_keys(&:to_sym)

        attribute :ids, ShowIds.optional

        attribute :number, Types::Integer.optional
        attribute :season, Types::Integer.optional
        attribute :title?, Types::String.optional
      end
    end
  end
end
