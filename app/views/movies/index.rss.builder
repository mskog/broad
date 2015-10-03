xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title 'Broad'
    xml.link movies_url
    xml.description 'Movies Feed'
    xml.language "en"

    @view.each do |movie|
      xml.item do
        xml.title movie.title.titleize
        xml.link download_movie_url(movie.id, key: movie.key)
        xml.pubDate movie.created_at.to_s(:rfc822)
      end
    end
  end
end
