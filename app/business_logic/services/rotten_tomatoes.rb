module Services
  # TODO This doesn't belong here
  class RottenTomatoes
    URL_REGEXP = /rottentomatoes.com\/m\/([^\/]+)\/?/
    URL = 'http://www.rottentomatoes.com/'

    def self.matches?(data)
      URL_REGEXP =~ data
    end

    def self.from_data(data)
      from_url(data)
    end

    def self.from_url(url)
      matches = URL_REGEXP.match(url)
      raise InvalidDataError unless matches
      new(matches[1])
    end

    def initialize(query)
      @query = query
    end

    def query
      @query.titleize
    end

    def url
      "#{URL}m/#{@query}/"
    end

    class InvalidDataError < StandardError; end
  end
end
