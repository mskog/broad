module Services
  module Trakt
    module Data
      class HistoryEpisode
        include Virtus.model

        attribute :episode, Episode
        attribute :show, Show
      end
    end
  end
end
