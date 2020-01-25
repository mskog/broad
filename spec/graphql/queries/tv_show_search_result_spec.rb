require "spec_helper"

describe "TV Show Search Result", type: :request do
  Given(:query) do
    <<-GRAPHQL
      {
        tvShowSearchResult(imdbId: "tt3032476"){title year}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  Then{expect(parsed_response["data"]["tvShowSearchResult"]["title"]).to eq "Better Call Saul"}
  And{expect(parsed_response["data"]["tvShowSearchResult"]["year"]).to eq 2015}
end
