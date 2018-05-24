module Services
  module Trakt
    module Data
      class ShowExtended
        include Virtus.model

        attribute :ids, ShowIds

        attribute :title, String
        attribute :year, Integer

        attribute :overview, String
        attribute :first_aired, Date
        attribute :trailer, String
        attribute :homepage, String
        attribute :rating, Float
        attribute :runtime, Integer
        attribute :votes, Integer
        attribute :updated_at, DateTime
        attribute :language, String
        attribute :genres, Array[String]
        attribute :certification, String

        attribute :country, String
        attribute :network, String

        attribute :status, String
        attribute :aired_episodes, Integer
      end
    end
  end
end
