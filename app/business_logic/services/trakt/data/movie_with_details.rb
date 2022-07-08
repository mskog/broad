# typed: false
module Services
  module Trakt
    module Data
      class MovieWithDetails < Services::Trakt::Data::Movie
        attribute :images?, Images.optional

        attribute :overview?, Types::String.optional
      end
    end
  end
end
