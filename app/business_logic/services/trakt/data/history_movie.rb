module Services
  module Trakt
    module Data
      class HistoryMovie
        include Virtus.model

        attribute :movie, ::Services::Trakt::Data::Movie
      end
    end
  end
end
