module Services
  module Trakt
    module Data
      class HistoryEpisode < Dry::Struct
        transform_keys(&:to_sym)

        attribute :episode, ::Services::Trakt::Data::Episode
        attribute :show, ::Services::Trakt::Data::Show
      end
    end
  end
end
