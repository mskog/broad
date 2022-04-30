class CacheBase64ImageJob < ActiveJob::Base
  queue_as :default

  def perform(url)
    return if url.blank?
    Rails.cache.fetch("base64_#{url}", expires_in: 1.year) do
      data = Down.download("https://thumbs.mskog.com/200x/filters:format(jpeg):quality(20):blur(10)/#{url}")
      Base64.encode64(data.read).gsub("\n", "")
    rescue Down::Error
      nil
    end
  end
end
