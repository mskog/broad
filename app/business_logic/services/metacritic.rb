module Services
  # TODO: This doesn't belong here
  class Metacritic
    URL_REGEXP = %r{metacritic.com/(tv|movie)/([^/]+)/?}.freeze
    URL = "http://www.metacritic.com/".freeze

    def self.matches?(data)
      URL_REGEXP =~ data
    end

    def self.from_data(data)
      from_url(data)
    end

    def self.from_url(url)
      matches = URL_REGEXP.match(url)
      raise InvalidDataError unless matches
      new(matches[1], matches[2].split("?").first)
    end

    def initialize(type, query)
      @type = type
      @query = query
    end

    def query
      @query.gsub(/\_[0-9]{4}$/, "").rstrip.titleize
    end

    def url
      "#{URL}#{@type}/#{@query}/"
    end

    class InvalidDataError < StandardError; end
  end
end
