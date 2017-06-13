module Services
  module Trakt
    module Data
      class HistoryMovie
        include Virtus.model

        attribute :movie, ::Services::Trakt::Data::Movie
        attribute :watched_at, DateTime
      end
    end
  end
end
