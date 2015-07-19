xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title 'Broad'
    xml.link feed_index_url
    xml.description 'BTN Feed'
    xml.language "en"

    @view.each do |episode|
      xml.item do
        xml.title episode.best_release.title
        xml.link episode.best_release.url
        xml.pubDate episode.created_at.to_s(:rfc822)
      end
    end
  end
end
