xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Broad"
    xml.link movie_downloads_url
    xml.description "Movies Feed"
    xml.language "en"

    @view.each do |movie|
      xml.item do
        xml.title "#{movie.title} #{movie.download_at}".parameterize
        xml.link download_movie_download_url(movie.id, key: movie.key, download_at: movie.download_at.to_i)
        xml.pubDate movie.created_at.to_s(:rfc822)
      end
    end
  end
end
