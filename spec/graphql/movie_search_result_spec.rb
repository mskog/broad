require "spec_helper"

describe "Movie Search Result", type: :request do
  Given(:query) do
    <<-GRAPHQL
      {
        movieSearchResult(imdbId: "tt0078748"){title year}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  Then{expect(parsed_response["data"]["movieSearchResult"]["title"]).to eq "Alien"}
  And{expect(parsed_response["data"]["movieSearchResult"]["year"]).to eq 1979}
end
