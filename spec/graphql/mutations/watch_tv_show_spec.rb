require "spec_helper"

describe "Watch tv show", type: :request do
  Given!(:tv_show){create :tv_show, id: 22_999, watching: false}

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

  Given(:parsed_response){JSON.parse(@response.body)}
  Then{expect(parsed_response["data"]["watchTvShow"]["id"]).to eq tv_show.id}
  And{expect(reloaded_tv_show.watching).to be_truthy}
end
