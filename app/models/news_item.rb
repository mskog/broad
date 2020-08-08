class NewsItem < ActiveRecord::Base
  belongs_to :newsworthy, polymorphic: true

  after_commit :fetch_metadata, :on => :create

  def fetch_metadata
    # TODO: Fix this. Use fakes
    return if Rails.env.test?
    client = Faraday.new(:url => "https://faas.mskog.com") do |builder|
      builder.request :json
      builder.response :json
      builder.adapter Faraday.default_adapter
    end

    response = client.get("/function/readability", url: url)
    update metadata: response.body
  end
end
