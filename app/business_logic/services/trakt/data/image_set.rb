module Services
  module Trakt
    module Data
      class ImageSet
        include Virtus.model

        attribute :full
        attribute :medium
        attribute :thumb
      end
    end
  end
end
