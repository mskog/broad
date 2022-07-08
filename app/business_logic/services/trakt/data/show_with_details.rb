# typed: false
module Services
  module Trakt
    module Data
      class ShowWithDetails < Show
        transform_keys(&:to_sym)

        attribute? :images, Images.optional
        attribute? :overview, Types::String.optional
        attribute? :status, ::Types::String.optional
      end
    end
  end
end
