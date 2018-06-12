module Services
  module Trakt
    module Data
      class Images
        include Virtus.model

        attribute :poster, ImageSet
        attribute :fanart, ImageSet
      end
    end
  end
end
