module Types
  include Dry.Types()

  DowncasedString = Coercible::String.constructor(&:downcase)
  UnderscoredDowncasedString = Coercible::String.constructor{|value| value.downcase.gsub(/\s+/, '_')}
  ImdbId = Coercible::String.constructor{|value| "tt#{value}".tr("tttt", "tt")}
end
