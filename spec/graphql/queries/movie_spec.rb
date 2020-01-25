require "spec_helper"

describe "Movie", type: :request do
  Given!(:movie_the_matrix){create :movie, id: 22_999, title: "The Matrix", watched: true, watched_at: Date.yesterday}
  Given!(:movie_batman){create :movie, title: "Batman", download_at: Date.yesterday}

  Given(:query) do
    <<-GRAPHQL
      {
        movie(id: 22999){id title}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  Then{expect(parsed_response["data"]["movie"]["id"]).to eq 22_999}
end
