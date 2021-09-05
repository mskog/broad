module Services
  module PTP
    class Movie < Dry::Struct
      transform_keys do |key|
        key.to_s.underscore.downcase.to_sym
      end

      attribute :title, Types::String
      attribute :auth_key, Types::String
      attribute :imdb_id, Types::String.optional

      attribute :releases, Types::Array.of(Services::PTP::Release)
    end
  end
end
