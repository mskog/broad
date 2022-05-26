module Services
  module N8n
    class Api
      def release_dates(movie_title)
        response = HTTP
                   .basic_auth(user: ENV["N8N_USERNAME"], pass: ENV["N8N_PASSWORD"])
                   .get("https://n8n.mskog.com/webhook/#{ENV['N8N_MOVIE_RELEASE_DATES_ID']}", params: {query: movie_title})
                   .body

        JSON.parse(response)["data"].map do |item|
          ReleaseDate.new(item)
        end
      end
    end

    class ReleaseDate < Dry::Struct
      transform_keys do |key|
        key.to_s.underscore.downcase.to_sym
      end

      attribute :type, Types::String
      attribute :release_date, Types::JSON::Date
    end
  end
end
