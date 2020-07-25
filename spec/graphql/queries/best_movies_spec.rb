require "spec_helper"

describe "Best Movies", type: :request do
  Given(:query) do
    <<-GRAPHQL
      {
        bestMovies(year: 2020) {
          id
        }
      }
    GRAPHQL
  end

  Given!(:movie_2020){create :movie, release_date: "2020-01-01", watched: true}
  Given!(:movie_2020_unwatched){create :movie, release_date: "2020-01-01"}
  Given!(:movie_2019){create :movie, release_date: "2019-01-01", watched: true}

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  context "Default" do
    Then{expect(parsed_response["data"]["bestMovies"].count).to eq 1}
    And{expect(parsed_response["data"]["bestMovies"].first["id"]).to eq movie_2020.id}
  end
end
