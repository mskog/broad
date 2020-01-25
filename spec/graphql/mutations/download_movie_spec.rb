require "spec_helper"

describe "Add movie to waitlist", type: :request do
  Given(:query) do
    <<-GRAPHQL
      mutation{
        downloadMovie(imdbId: "tt0386064"){id title}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:expected_movie){Movie.last}

  Given(:parsed_response){JSON.parse(@response.body)}
  Then{expect(parsed_response["data"]["downloadMovie"]["id"]).to eq expected_movie.id}
  And{expect(expected_movie.waitlist).to be_falsy}
  And{expect(expected_movie.download_at).to be_present}
end
