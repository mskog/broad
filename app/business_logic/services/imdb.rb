module Services
  class Imdb
    URL_REGEXP = /imdb.com\/title\/(tt[0-9]+)/
    URL = "http://www.imdb.com"

    def self.from_url(url)
      matches = URL_REGEXP.match(url)
      raise InvalidUrlError unless matches
      new(matches[1])
    end

    attr_reader :id

    def initialize(id)
      @id = id
    end

    def url
      "#{URL}/title/#{@id}"
    end

    class InvalidUrlError < StandardError; end
  end
end
