require "spec_helper"

describe "Force movie download", type: :request do
  Given!(:movie){create :movie, id: 22_999}

  Given(:query) do
    <<-GRAPHQL
      mutation{
        forceMovieDownload(id: 22999){id title}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:reloaded_movie){movie.reload}

  Given(:parsed_response){JSON.parse(@response.body)}
  Then{expect(parsed_response["data"]["forceMovieDownload"]["id"]).to eq movie.id}
  And{expect(reloaded_movie.waitlist).to be_falsy}
  And{expect(reloaded_movie.download_at).to be_present}
end
