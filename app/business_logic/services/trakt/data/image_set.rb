# typed: false
module Services
  module Trakt
    module Data
      class ImageSet < Dry::Struct
        transform_keys(&:to_sym)

        attribute :full, Types::String.optional
        attribute :medium, Types::String.optional
        attribute :thumb, Types::String.optional
      end
    end
  end
end
