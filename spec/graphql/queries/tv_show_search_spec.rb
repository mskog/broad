require "spec_helper"

describe "TV Show Search", type: :request do
  Given(:query) do
    <<-GRAPHQL
      {
        tvShowSearch(query: "better call saul"){title year}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  Then{expect(parsed_response["data"]["tvShowSearch"].first["title"]).to eq "Talking Saul"}
  And{expect(parsed_response["data"]["tvShowSearch"].first["year"]).to eq 2016}
end
