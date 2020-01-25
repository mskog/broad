require "spec_helper"

describe "Collect tv show", type: :request do
  context "with an existing TV Show" do
    Given!(:tv_show){create :tv_show, id: 22_999}

    Given(:query) do
      <<-GRAPHQL
        mutation{
          collectTvShow(id: 22999){id name}
        }
      GRAPHQL
    end

    When do
      post graphql_path, env: @env, params: {query: query}
    end

    Given(:reloaded_tv_show){tv_show.reload}

    Given(:parsed_response){JSON.parse(@response.body)}
    Then{expect(parsed_response["data"]["collectTvShow"]["id"]).to eq tv_show.id}
    And{expect(reloaded_tv_show.collected).to be_truthy}
  end

  context "with a new TV Show" do
    Given(:query) do
      <<-GRAPHQL
        mutation{
          collectTvShow(id: "tt1049413"){id name}
        }
      GRAPHQL
    end

    When do
      post graphql_path, env: @env, params: {query: query}
    end

    Given(:expected_tv_show){TvShow.last}

    Given(:parsed_response){JSON.parse(@response.body)}
    Then{expect(parsed_response["data"]["collectTvShow"]["id"]).to eq expected_tv_show.id}
    And{expect(expected_tv_show.collected).to be_truthy}
  end
end
