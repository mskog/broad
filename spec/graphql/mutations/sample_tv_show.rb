require "spec_helper"

describe "Sample tv show", type: :request do
  context "with an existing TV Show" do
    Given!(:tv_show){create :tv_show, id: 22_999}

    Given(:query) do
      <<-GRAPHQL
        mutation{
          sampleTvShow(id: 22999){id name}
        }
      GRAPHQL
    end

    When do
      post graphql_path, env: @env, params: {query: query}
    end

    Given(:reloaded_tv_show){tv_show.reload}

    Given(:parsed_response){JSON.parse(@response.body)}
    Then{expect(parsed_response["data"]["sampleTvShow"]["id"]).to eq tv_show.id}
    And{expect(reloaded_tv_show.episodes.count).to eq 1}
  end

  context "with a new TV Show" do
    Given(:query) do
      <<-GRAPHQL
        mutation{
          sampleTvShow(id: "tt1049413"){id name}
        }
      GRAPHQL
    end

    When do
      post graphql_path, env: @env, params: {query: query}
    end

    Given(:expected_tv_show){TvShow.last}

    Given(:parsed_response){JSON.parse(@response.body)}
    Then{expect(parsed_response["data"]["sampleTvShow"]["id"]).to eq expected_tv_show.id}
    And{expect(expected_tv_show.episodes.count).to eq 1}
  end
end
