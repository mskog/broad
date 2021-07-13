module Types
  class CalendarItemType < Types::BaseUnion
    possible_types Types::MovieType, Types::CalendarEpisodeType

    def self.resolve_type(object, _context)
      if object.is_a?(Movie)
        Types::MovieType
      else
        Types::CalendarEpisodeType
      end
    end
  end
end
