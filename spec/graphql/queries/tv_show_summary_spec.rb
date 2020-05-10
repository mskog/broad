require "spec_helper"

describe "TV Show summary", type: :request do
  Given(:query) do
    <<-GRAPHQL
      {
        tvShowSummary(imdbId: "tt2654620"){
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

  Then{expect(parsed_response["data"]["tvShowSummary"]["title"]).to eq "The Strain"}
end
