require "spec_helper"

describe "TV Show Calendar", type: :request do
  Given(:query) do
    <<-GRAPHQL
      {
        tvShowsCalendar{id name}
      }
    GRAPHQL
  end

  Given!(:credential){create :credential, name: "trakt"}
  Given!(:tv_show_watching){create :tv_show, name: "Teen Wolf", imdb_id: "tt1567432", watching: true, trakt_details: {images: {poster: {thumb: "hello.jpg"}}}}
  Given!(:tv_show_not_watching){create :tv_show, name: "Hannibal", imdb_id: "some_id", watching: false}

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  Then{expect(parsed_response["data"]["tvShowsCalendar"].first["name"]).to eq "Teen Wolf"}
end
