module ImageHelper
  # TODO: ENV, not raw strings
  def thumbor_image_tag(source, options = {})
    image_tag("https://thumbs.mskog.com/" + source, options)
  end

  # TODO: ENV, not raw strings
  def thumbor_image_url(source)
    "https://thumbs.mskog.com/#{source}"
  end
end
