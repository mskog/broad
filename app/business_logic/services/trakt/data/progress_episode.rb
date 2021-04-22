module Services
  module Trakt
    module Data
      class ProgressEpisode
        include Virtus.model

        attribute :number, Integer
        attribute :completed, Boolean
        attribute :collected_at, DateTime

        def completed?
          completed == true
        end
      end
    end
  end
end
