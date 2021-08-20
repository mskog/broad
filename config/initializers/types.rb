module Types
  include Dry.Types()

  DowncasedString = Coercible::String.constructor(&:downcase)
  UnderscoredDowncasedString = Coercible::String.constructor{|value| value.downcase.gsub(/\s+/, '_')}
end
