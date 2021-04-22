module Services
  module Trakt
    module Data
      class ProgressSeason
        include Virtus.model

        attribute :number, Integer
        attribute :title, String
        attribute :aired, Integer
        attribute :completed, Integer

        attribute :episodes, [Services::Trakt::Data::ProgressEpisode]

        def completed?
          aired == completed
        end
      end
    end
  end
end
