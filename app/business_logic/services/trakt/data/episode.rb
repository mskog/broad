module Services
  module Trakt
    module Data
      class Episode
        include Virtus.model

        attribute :ids, ShowIds

        attribute :number, Integer
        attribute :season, Integer
        attribute :title, String
      end
    end
  end
end
