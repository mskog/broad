require "spec_helper"

describe "Add movie to waitlist", type: :request do
  Given(:query) do
    <<-GRAPHQL
      mutation{
        addMovieToWaitlist(imdbId: "tt0386064"){id}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:expected_movie){Movie.last}

  Given(:parsed_response){JSON.parse(@response.body)}
  Then{expect(parsed_response["data"]["addMovieToWaitlist"]["id"]).to eq Movie.last.id}
  And{expect(expected_movie.waitlist).to be_truthy}
  And{expect(expected_movie.download_at).to be_falsy}
end
