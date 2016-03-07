module ImageHelper
  def thumbor_image_tag(source, options={})
    image_tag("https://thumbs.picyo.me/"+source, options)
  end

  def thumbor_image_url(source)
    "https://thumbs.picyo.me/#{source}"
  end
end
