require "spec_helper"

describe "Movie summary", type: :request do
  Given(:query) do
    <<-GRAPHQL
      {
        movieSummary(imdbId: "tt0078748"){
          overview
          rating
          title
          status
        }
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  Then{expect(parsed_response["data"]["movieSummary"]["title"]).to eq "Alien"}
end
