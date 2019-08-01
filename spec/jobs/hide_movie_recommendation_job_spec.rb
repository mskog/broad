require "spec_helper"

# TODO: Fix spec
describe HideMovieRecommendationJob do
  subject{described_class.new}

  Given!(:credential){create :credential, name: "trakt"}

  Given!(:stub) do
    stub_request(:delete, "https://api-v2launch.trakt.tv/recommendations/movies/#{movie_recommendation.trakt_id}")
      .with(:headers => {"Accept" => "*/*", "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3", "Authorization" => "Bearer access", "Content-Type" => "application/json", "Trakt-Api-Key" => "37c68ef66269b237bf9c7163233529f59965b5e8c5f5d68109d8ef95ebbbc461", "Trakt-Api-Version" => "2", "User-Agent" => "Faraday v0.9.2"})
      .to_return(:status => 200, :body => "", :headers => {})
  end

  Given(:movie_recommendation){create :movie_recommendation}
  # When{subject.perform(movie_recommendation)}
  # Then{expect(stub).to have_been_requested}
  # Then{expect(MovieRecommendation.count).to eq 0}
end
