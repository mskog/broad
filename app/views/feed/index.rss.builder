#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.language "en"

    @view.each do |episode|
      xml.item do
        xml.title episode.best_release.title
        xml.link episode.best_release.url
      end
    end
  end
end
