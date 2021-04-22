module Services
  module Trakt
    module Data
      class ProgressShow
        include Virtus.model

        attribute :aired, Integer
        attribute :completed, Integer
        attribute :last_collected_at, DateTime
        attribute :seasons, [Services::Trakt::Data::ProgressSeason]

        def completed?
          aired == completed
        end
      end
    end
  end
end
