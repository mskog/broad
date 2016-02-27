module Services
  module Trakt
    module Data
      class ShowWithDetails < Show
        attribute :images, Images
        attribute :overview
        attribute :status
      end
    end
  end
end
