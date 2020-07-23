require "spec_helper"

describe Services::Trakt::Sync do
  subject{described_class.new}

  describe "#rate_movie" do
    Given!(:credential){create :credential}

    Given(:rating){5}
    Given(:imdb_id){"tt12345"}

    Given(:expected_post_data) do
      {
        movies: [
          {
            rating: rating,
            ids: {
              imdb: imdb_id
            }
          }
        ]
      }
    end

    Given!(:stub) do
      stub_request(:post, "#{ENV['TRAKT_APIURL']}/sync/ratings")
        .with(body: expected_post_data.to_json, headers: {"Authorization": "Bearer #{credential.data['access_token']}"})
    end

    When{subject.rate_movie(imdb_id, rating)}
    Then{expect(stub).to have_been_requested}
  end
end
