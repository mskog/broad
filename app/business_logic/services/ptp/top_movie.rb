module Services
  module PTP
    class TopMovie < Dry::Struct
      transform_keys do |key|
        key.to_s.underscore.downcase.to_sym
      end

      attribute :title?, Types::String.optional
      attribute :imdb_id?, Types::ImdbId.optional
      attribute :year?, Types::Coercible::Integer.optional
      attribute :cover?, Types::String.optional
      attribute :tags?, Types::Array.of(Types::String).optional
      attribute :imdb_rating?, Types::Coercible::Float.optional
      attribute :mc_url?, Types::String.optional
      attribute :ptp_rating?, Types::Coercible::Float.optional
      attribute :youtube_id?, Types::String.optional
      attribute :synopsis?, Types::String.optional
    end
  end
end
