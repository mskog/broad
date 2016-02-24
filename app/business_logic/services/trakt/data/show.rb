module Services
  module Trakt
    module Data
      class Show
        include Virtus.model

        attribute :ids, ShowIds

        attribute :title, String
        attribute :year, Integer
      end
    end
  end
end
