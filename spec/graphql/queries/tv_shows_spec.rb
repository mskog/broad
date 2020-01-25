require "spec_helper"

# TODO: Missing some specs for releaes and such
describe "TV Shows", type: :request do
  Given(:query) do
    <<-GRAPHQL
      {
        tvShows{id name}
      }
    GRAPHQL
  end

  Given!(:tv_show_hannibal){create :tv_show, name: "Hannibal", watching: false}
  Given!(:tv_show_the_expanse){create :tv_show, name: "The Expanse", status: "ended"}
  Given!(:tv_show_the_breaking_bad){create :tv_show, name: "Breaking bad", watching: true}

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  context "With no parameters" do
    Then{expect(parsed_response["data"]["tvShows"].count).to eq 3}
  end

  context "With a query filter" do
    Given(:query) do
      <<-GRAPHQL
        {
          tvShows(query: "hannibal"){id name}
        }
      GRAPHQL
    end
    Then{expect(parsed_response["data"]["tvShows"].count).to eq 1}
    And{expect(parsed_response["data"]["tvShows"].first["id"]).to eq tv_show_hannibal.id}
  end

  context "With pagination" do
    Given(:query) do
      <<-GRAPHQL
        {
          tvShows(first: 1, skip: 1){id name}
        }
      GRAPHQL
    end
    Then{expect(parsed_response["data"]["tvShows"].count).to eq 1}
    And{expect(parsed_response["data"]["tvShows"].first["id"]).to eq tv_show_the_expanse.id}
  end

  context "With watching category" do
    Given(:query) do
      <<-GRAPHQL
        {
          tvShows(category: "watching"){id name}
        }
      GRAPHQL
    end
    Then{expect(parsed_response["data"]["tvShows"].count).to eq 1}
    And{expect(parsed_response["data"]["tvShows"].first["id"]).to eq tv_show_the_breaking_bad.id}
  end

  context "With not_watching category" do
    Given(:query) do
      <<-GRAPHQL
        {
          tvShows(category: "not_watching"){id name}
        }
      GRAPHQL
    end
    Then{expect(parsed_response["data"]["tvShows"].count).to eq 1}
    And{expect(parsed_response["data"]["tvShows"].first["id"]).to eq tv_show_hannibal.id}
  end

  context "With ended category" do
    Given(:query) do
      <<-GRAPHQL
        {
          tvShows(category: "ended"){id name}
        }
      GRAPHQL
    end
    Then{expect(parsed_response["data"]["tvShows"].count).to eq 1}
    And{expect(parsed_response["data"]["tvShows"].first["id"]).to eq tv_show_the_expanse.id}
  end
end
