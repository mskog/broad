require "spec_helper"

describe "Movie Search", type: :request do
  Given(:query) do
    <<-GRAPHQL
      {
        movieSearch(query: "Terminator"){title year}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  Then{expect(parsed_response["data"]["movieSearch"].first["title"]).to eq "Terminator 2: Judgment Day"}
  And{expect(parsed_response["data"]["movieSearch"].first["year"]).to eq 1991}
end
