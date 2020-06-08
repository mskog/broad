require "spec_helper"

describe "Set episode as watched", type: :request do
  Given(:query) do
    <<-GRAPHQL
      mutation{
        episodeWatched(id: "#{episode.id}"){id}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given!(:episode){create :episode}

  Given(:reloaded_episode){episode.reload}

  Given(:parsed_response){JSON.parse(@response.body)}
  Then{expect(parsed_response["data"]["episodeWatched"]["id"]).to eq episode.id}
  And{expect(reloaded_episode.watched).to be_truthy}
  And{expect(reloaded_episode.watched_at).to be_present}
end
