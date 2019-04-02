require 'spec_helper'

describe "API:V1:TvShowsCalendar", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/json'
  end

  Given!(:credential){create :credential, name: 'trakt'}

  describe "Show" do
    Given!(:tv_show_watching){create :tv_show, name: 'Teen Wolf', imdb_id: 'tt1567432', watching: true, trakt_details: {images: {poster: {thumb: 'hello.jpg'}}}}
    Given!(:tv_show_not_watching){create :tv_show, name: 'Hannibal', imdb_id: 'some_id', watching: false}

    When do
      get api_v1_tv_shows_calendar_path, env: @env
    end

    Given(:parsed_response){JSON.parse(response.body)}
    Given(:first_episode){parsed_response.first.second.first}

    Then{expect(parsed_response.count).to eq 1}
    And{expect(first_episode.dig("episode", "ids", "imdb")).to be_nil}
    And{expect(first_episode.dig("episode", "ids", "trakt")).to eq 1765462}
    And{expect(first_episode.dig("episode", "season")).to eq 5}
    And{expect(first_episode.dig("episode", "number")).to eq 18}
    And{expect(first_episode.dig("episode", "title")).to eq "The Maid of Gévaudan"}
    And{expect(first_episode.dig("first_aired")).to eq "2016-02-24T02:00:00.000+00:00"}
    And{expect(first_episode.dig("show", "title")).to eq "Teen Wolf"}
  end
end
