require "spec_helper"

describe "Best Movies", type: :request do
  Given!(:movie_2020){create :movie, release_date: "2020-01-01", watched: true, watched_at: "2022-05-01"}
  Given!(:movie_2020_unwatched){create :movie, release_date: "2020-01-01", watched_at: "2021-01-01"}
  Given!(:movie_2019){create :movie, release_date: "2019-01-01", watched: true, watched_at: "2019-01-15"}

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  context "with released" do
    Given(:query) do
      <<-GRAPHQL
      {
        bestMovies(year: 2020, category: RELEASED) {
          id
        }
      }
      GRAPHQL
    end

    Then{expect(parsed_response["data"]["bestMovies"].count).to eq 1}
    And{expect(parsed_response["data"]["bestMovies"].first["id"]).to eq movie_2020.id}
  end

  context "with watched" do
    Given(:query) do
      <<-GRAPHQL
      {
        bestMovies(year: 2019, category: WATCHED) {
          id
        }
      }
      GRAPHQL
    end

    Then{expect(parsed_response["data"]["bestMovies"].count).to eq 1}
    And{expect(parsed_response["data"]["bestMovies"].first["id"]).to eq movie_2019.id}
  end
end
