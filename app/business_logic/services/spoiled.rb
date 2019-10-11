module Services
  class Spoiled
    API_URL = "https://spoiled.mskog.com".freeze

    def initialize(title)
      @title = title
    end

    def tomatometer
      details["tomatometer"]
    end

    def audience_score
      details["audience_score"]
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
