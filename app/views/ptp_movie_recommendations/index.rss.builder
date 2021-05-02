xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Broad"
    xml.link ptp_movie_recommendations_url
    xml.description "PTP Movie recommendations"
    xml.language "en"

    @movie_recommendations.each do |movie_recommendation|
      xml.item do
        xml.title movie_recommendation.title.to_s
        xml.link "https://broad.mskog.com/search/movies/details/#{movie_recommendation.imdb_id}"
        xml.description movie_recommendation.synopsis
      end
    end
  end
end
