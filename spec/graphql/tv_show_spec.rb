require "spec_helper"

describe "TV Show", type: :request do
  Given!(:tv_show_breaking_bad){create :tv_show, id: 22_999, name: "Breaking bad"}
  Given!(:tv_show_hannibal){create :tv_show, name: "Hannibal"}

  Given(:query) do
    <<-GRAPHQL
      {
        tvShow(id: 22999){id name}
      }
    GRAPHQL
  end

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  Then{expect(parsed_response["data"]["tvShow"]["id"]).to eq 22_999}
end
