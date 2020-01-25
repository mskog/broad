require "spec_helper"

describe "TV Show Details", type: :request do
  Given(:query) do
    <<-GRAPHQL
      {
        tvShowDetails(imdbId:"tt2654620"){title year}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  Then{expect(parsed_response["data"]["tvShowDetails"]["title"]).to eq "The Strain"}
  And{expect(parsed_response["data"]["tvShowDetails"]["year"]).to eq 2014}
end
