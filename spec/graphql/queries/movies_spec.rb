require "spec_helper"

# TODO: Missing some specs for releaes and such
describe "Movies", type: :request do
  Given(:query) do
    <<-GRAPHQL
      {
        movies{id title}
      }
    GRAPHQL
  end

  Given!(:movie_the_matrix){create :movie, title: "The Matrix", watched: true, watched_at: Date.yesterday}
  Given!(:movie_batman){create :movie, title: "Batman", download_at: Date.yesterday}
  Given!(:movie_shrek){create :movie, title: "Shrek", waitlist: true}

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  context "With no parameters" do
    Then{expect(parsed_response["data"]["movies"].count).to eq 3}
  end

  context "With a query filter " do
    Given(:query) do
      <<-GRAPHQL
        {
          movies(query: "matrix"){id title}
        }
      GRAPHQL
    end
    Then{expect(parsed_response["data"]["movies"].count).to eq 1}
    And{expect(parsed_response["data"]["movies"].first["id"]).to eq movie_the_matrix.id}
  end

  context "With pagination" do
    Given(:query) do
      <<-GRAPHQL
        {
          movies(first: 1, skip: 1){id title}
        }
      GRAPHQL
    end
    Then{expect(parsed_response["data"]["movies"].count).to eq 1}
    And{expect(parsed_response["data"]["movies"].first["id"]).to eq movie_batman.id}
  end

  context "With watched category" do
    Given(:query) do
      <<-GRAPHQL
        {
          movies(category: "watched"){id title}
        }
      GRAPHQL
    end
    Then{expect(parsed_response["data"]["movies"].count).to eq 1}
    And{expect(parsed_response["data"]["movies"].first["id"]).to eq movie_the_matrix.id}
  end

  context "With waitlist category" do
    Given(:query) do
      <<-GRAPHQL
        {
          movies(category: "waitlist"){id title}
        }
      GRAPHQL
    end
    Then{expect(parsed_response["data"]["movies"].count).to eq 1}
    And{expect(parsed_response["data"]["movies"].first["id"]).to eq movie_shrek.id}
  end

  context "With downloads category" do
    Given(:query) do
      <<-GRAPHQL
        {
          movies(category: "downloads"){id title}
        }
      GRAPHQL
    end
    Then{expect(parsed_response["data"]["movies"].count).to eq 1}
    And{expect(parsed_response["data"]["movies"].first["id"]).to eq movie_batman.id}
  end
end
