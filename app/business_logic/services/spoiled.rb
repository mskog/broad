module Services
  class Spoiled
    API_URL = "http://spoiled.mskog.com"

    def initialize(title)
      @title = title
    end

    def score
      details["score"]
    end

    private

    def details
      client.get("/", title: @title).body
    end

    def client
      Faraday.new(:url => API_URL) do |builder|
        builder.request  :url_encoded
        builder.response :json
        builder.adapter Faraday.default_adapter
      end
    end
  end
end
