require "spec_helper"

describe "Watch tv show", type: :request do
  Given(:query) do
    <<-GRAPHQL
      mutation{
        watchTvShow(id: 22999){id name}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:reloaded_tv_show){tv_show.reload}

  context "with a database id" do
    Given(:query) do
      <<-GRAPHQL
        mutation{
          watchTvShow(id: 22999){id name}
        }
      GRAPHQL
    end

    Given!(:tv_show){create :tv_show, id: 22_999, watching: false}
    Given(:parsed_response){JSON.parse(@response.body)}
    Then{expect(parsed_response["data"]["watchTvShow"]["id"]).to eq tv_show.id}
    And{expect(reloaded_tv_show.watching).to be_truthy}
  end

  context "with an imdb id" do
    Given(:query) do
      <<-GRAPHQL
        mutation{
          watchTvShow(id: "tt12345"){id name}
        }
      GRAPHQL
    end

    Given(:imdb_id){"tt12345"}
    Given(:tv_show){TvShow.last}

    Given(:parsed_response){JSON.parse(@response.body)}
    Then{expect(parsed_response["data"]["watchTvShow"]["id"]).to eq tv_show.id}
    And{expect(tv_show.watching).to be_truthy}
  end
end
