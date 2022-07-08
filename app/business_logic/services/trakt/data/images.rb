# typed: strict
module Services
  module Trakt
    module Data
      class Images < Dry::Struct
        transform_keys(&:to_sym)

        attribute :poster, ImageSet.optional
        attribute :fanart, ImageSet.optional
      end
    end
  end
end
