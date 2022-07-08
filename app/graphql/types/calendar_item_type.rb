# typed: true
module Types
  class CalendarItemType < Types::BaseUnion
    possible_types Types::CalendarMovieType, Types::CalendarEpisodeType

    def self.resolve_type(object, _context)
      if object.is_a?(MovieReleaseDate)
        Types::CalendarMovieType
      else
        Types::CalendarEpisodeType
      end
    end
  end
end
