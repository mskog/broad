module Services
  module Trakt
    module Data
      class MovieWithDetails < Services::Trakt::Data::Movie
        attribute :images, Images

        attribute :overview
      end
    end
  end
end
