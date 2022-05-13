require "spec_helper"

describe "Download season", type: :request do
  Given(:query) do
    <<-GRAPHQL
      mutation{
        downloadSeason(tvShowId: #{tv_show.id}, seasonNumber: #{season_number}){
          id
        }
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:tv_show){create :tv_show}
  Given(:season_number){1}

  Given(:parsed_response){JSON.parse(@response.body)}
  Then{expect(parsed_response["data"]["downloadSeason"]).to be_present}
  And{expect(tv_show.seasons.count).to eq 1}
  And{expect(tv_show.seasons.last.download_requested).to be_truthy}
end
