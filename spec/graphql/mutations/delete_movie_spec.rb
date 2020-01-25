require "spec_helper"

describe "Delete movie", type: :request do
  Given!(:movie){create :movie, id: 22_999, waitlist: true}

  Given(:query) do
    <<-GRAPHQL
      mutation{
        deleteMovie(id: 22999){id title}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}
  Then{expect(parsed_response["data"]["deleteMovie"]["id"]).to eq movie.id}
  And{expect(Movie.count).to eq 0}
end
