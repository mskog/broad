require "spec_helper"

describe "Rate movie", type: :request do
  include ActiveJob::TestHelper

  Given!(:movie){create :movie, id: 22_999, imdb_id: "tt12345"}

  Given(:query) do
    <<-GRAPHQL
      mutation{
        rateMovie(id: 22999, rating: 5){id}
      }
    GRAPHQL
  end

  Given!(:credential){create :credential}
  Given(:expected_post_data) do
    {
      movies: [
        {
          rating: 5,
          ids: {
            imdb: movie.imdb_id
          }
        }
      ]
    }
  end
  Given!(:stub) do
    stub_request(:post, "#{ENV['TRAKT_APIURL']}/sync/ratings")
      .with(body: expected_post_data.to_json, headers: {"Authorization": "Bearer #{credential.data['access_token']}"})
  end

  When do
    perform_enqueued_jobs do
      post graphql_path, env: @env, params: {query: query}
    end
  end

  Given(:parsed_response){JSON.parse(@response.body)}
  Then{expect(stub).to have_been_requested}
  And{expect(parsed_response["data"]["rateMovie"]["id"]).to eq movie.id}
end
