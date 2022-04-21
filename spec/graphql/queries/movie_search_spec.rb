require "spec_helper"

describe "Movie Search", type: :request do
  Given(:query) do
    <<-GRAPHQL
      {
        movieSearch(query: "Alien"){title year}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  Then{expect(parsed_response["data"]["movieSearch"].first["title"]).to eq "Alienate"}
  And{expect(parsed_response["data"]["movieSearch"].first["year"]).to eq 2016}
end
