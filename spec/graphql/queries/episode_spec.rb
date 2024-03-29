require "spec_helper"

describe "Episode", type: :request do
  Given!(:episode){create :episode, id: 22_999}
  Given!(:episode_release){create :episode_release, episode: episode}
  Given{create :episode}

  Given(:query) do
    <<-GRAPHQL
      {
        episode(id: 22999){id name bestRelease{id}}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  Then{expect(parsed_response["data"]["episode"]["id"]).to eq 22_999}
end
