module Services
  module Trakt
    module Data
      class MovieWithDetails < Movie
        attribute :images, Images

        attribute :overview
      end
    end
  end
end
