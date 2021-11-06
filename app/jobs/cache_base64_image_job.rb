class CacheBase64ImageJob < ActiveJob::Base
  queue_as :default

  def perform(url)
    return unless url.present?
    Rails.cache.fetch("base64_#{url}", expires_in: 1.year) do
      Base64.encode64(Down.download("https://thumbs.mskog.com/200x/filters:format(jpeg):quality(20):blur(10)/#{url}").read).gsub(
        "\n", ""
      )
    end
  end
end
