module Services
  # TODO: This doesn't belong here
  class RottenTomatoes
    URL_REGEXP = %r{rottentomatoes.com/(m|tv)/([^/]+)/?}.freeze
    URL = "http://www.rottentomatoes.com/".freeze

    def self.matches?(data)
      URL_REGEXP =~ data
    end

    def self.from_data(data)
      from_url(data)
    end

    def self.from_url(url)
      matches = URL_REGEXP.match(url)
      raise InvalidDataError unless matches
      new(matches[1], matches[2])
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
