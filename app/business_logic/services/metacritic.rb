module Services
  # TODO This doesn't belong here
  class Metacritic
    URL_REGEXP = /metacritic.com\/movie\/([^\/]+)\/?/
    URL = 'http://www.metacritic.com/'

    def self.matches?(data)
      URL_REGEXP =~ data
    end

    def self.from_data(data)
      from_url(data)
    end

    def self.from_url(url)
      matches = URL_REGEXP.match(url)
      raise InvalidDataError unless matches
      new(matches[1].split("?").first)
    end

    def initialize(query)
      @query = query
    end

    def query
      @query.gsub(/\_[0-9]{4}$/, '').rstrip.titleize
    end

    def url
      "#{URL}movie/#{@query}/"
    end

    class InvalidDataError < StandardError; end
  end
end
