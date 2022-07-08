# typed: true
module Services
  class Query
    class Anything
      def self.matches?(*)
        true
      end

      def self.from_data(data)
        new(data)
      end

      def initialize(data)
        @data = data
      end

      def query
        @data
      end
    end

    def initialize(query)
      @query = build_query(query)
    end

    def imdb_id
      @query.try(:imdb_id)
    end

    def query
      @query.query
    end

    private

    def build_query(query)
      query_services.find do |service|
        service.matches? query
      end.from_data(query)
    end

    def query_services
      [
        Services::Imdb,
        Services::RottenTomatoes,
        Services::Metacritic,
        Anything
      ]
    end
  end
end
