require "spec_helper"

describe "Calendar", type: :request do
  Given(:query) do
    <<-GRAPHQL
      {
        calendar{
        ...on Movie{
          title
          availableDate
        }

        ...on CalendarEpisode{
          id
          name
          firstAired
          title
          season
        }}
      }
    GRAPHQL
  end

  Given!(:movie_downloaded){create :movie, waitlist: false}
  Given!(:movie_waitlist){create :movie, waitlist: true, available_date: 60.days.from_now}

  Given!(:credential){create :credential, name: "trakt"}
  Given!(:tv_show_watching){create :tv_show, name: "Teen Wolf", imdb_id: "tt1567432", watching: true, trakt_details: {images: {poster: {thumb: "hello.jpg"}}}}
  Given!(:tv_show_not_watching){create :tv_show, name: "Hannibal", imdb_id: "some_id", watching: false}

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  Then{expect(parsed_response["data"]["calendar"].count).to eq 2}
  And{expect(parsed_response["data"]["calendar"].first["name"]).to eq "Teen Wolf"}
  And{expect(parsed_response["data"]["calendar"].second["title"]).to eq movie_waitlist.title}
end
