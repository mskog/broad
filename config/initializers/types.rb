# typed: false

module Types
  include Dry.Types()

  DowncasedString = Coercible::String.constructor(&:downcase)
  IntegerWithLeadingZero = Integer.constructor{|value| value.to_i}
  UnderscoredDowncasedString = Coercible::String.constructor{|value| value.downcase.gsub(/\s+/, "_")}
  ImdbId = Coercible::String.constructor{|value| "tt#{value}".tr("tttt", "tt")}
end
