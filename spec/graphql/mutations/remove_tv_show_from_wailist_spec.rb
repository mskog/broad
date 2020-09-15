require "spec_helper"

describe "Remove TV Show from waitlist", type: :request do
  Given!(:tv_show){create :tv_show, id: 22_999, waitlist: true}

  Given(:query) do
    <<-GRAPHQL
      mutation{
        removeTvShowFromWaitlist(id: 22999){id name}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:reloaded_tv_show){tv_show.reload}

  Given(:parsed_response){JSON.parse(@response.body)}
  Then{expect(parsed_response["data"]["removeTvShowFromWaitlist"]["id"]).to eq tv_show.id}
  And{expect(reloaded_tv_show.waitlist).to be_falsy}
end
