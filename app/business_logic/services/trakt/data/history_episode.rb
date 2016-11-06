module Services
  module Trakt
    module Data
      class HistoryEpisode
        include Virtus.model

        attribute :episode, ::Services::Trakt::Data::Episode
        attribute :show, ::Services::Trakt::Data::Show
      end
    end
  end
end
