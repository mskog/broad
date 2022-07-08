# typed: true
class Types::NewsworthyType < Types::BaseUnion
  possible_types Types::MovieType,
                 Types::TvShowType

  def self.resolve_type(object, _context)
    if object.is_a?(Movie)
      Types::MovieType
    elsif object.is_a?(TvShow)
      Types::TvShowType
    end
  end
end
