# typed: false

module Services
  module Ptp
    class Release < Dry::Struct
      transform_keys do |key|
        key.to_s.underscore.downcase.to_sym
      end

      attribute :id, Types::Integer
      attribute :checked, Types::Bool
      attribute :codec, Types::DowncasedString.optional
      attribute :container, Types::DowncasedString.optional
      attribute :golden_popcorn, Types::Bool
      attribute :leechers, Types::Coercible::Integer
      attribute :seeders, Types::Coercible::Integer
      attribute :quality, Types::DowncasedString.optional
      attribute :release_name, Types::DowncasedString.optional
      attribute :remaster_title?, Types::DowncasedString.optional
      attribute :resolution, Types::DowncasedString.optional
      attribute :scene, Types::Bool
      attribute :size, Types::Coercible::Integer
      attribute :snatched, Types::Coercible::Integer
      attribute :source, Types::DowncasedString.optional
      attribute :upload_time, Types::JSON::DateTime.optional
    end
  end
end
