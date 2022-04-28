xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Broad"
    xml.link episodes_url
    xml.description "BTN Feed"
    xml.language "en"

    @view.each do |episode|
      xml.item do
        xml.title "#{episode.name} - S#{episode.season_number.to_s.rjust(2, '0')}E#{episode.episode.to_s.rjust(2, '0')} - #{episode.best_available_release.id}"
        xml.link download_episode_url(episode.id, key: episode.key)
        xml.pubDate episode.created_at.to_s(:rfc822)
      end
    end
  end
end
