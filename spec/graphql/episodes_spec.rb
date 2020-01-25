require "spec_helper"

describe "Episodes", type: :request do
  Given{create_list :episode, 2}

  Given{create :episode, releases: [create(:episode_release)]}
  Given{create :episode, releases: [create(:episode_release)]}

  Given(:query) do
    <<-GRAPHQL
      {
        episodes{id}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  context "With no filters" do
    Then{expect(parsed_response["data"]["episodes"].count).to eq 2}
  end

  context "With filter" do
    Given(:query) do
      <<-GRAPHQL
        {
          episodes(first: 1){id}
        }
      GRAPHQL
    end
    Then{expect(parsed_response["data"]["episodes"].count).to eq 1}
  end
end
