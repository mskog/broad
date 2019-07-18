require 'spec_helper'

describe "API:V1:TvShows", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/json'
  end

  describe "Index" do
    Given(:params){{}}

    Given!(:tv_shows){create_list :tv_show, 2}

    When do
      get api_v1_tv_shows_path, env: @env, params: params
    end

    Given(:parsed_response){JSON.parse(response.body)}
    Given(:first_result){parsed_response.first}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response.count).to eq 2}
    And{expect(parsed_response.map{|tv_show| tv_show["name"]}).to eq tv_shows.map(&:name)}
  end

  describe "Show" do
    Given(:params){{}}

    Given!(:tv_show){create :tv_show}
    Given!(:episode_without_release){create :episode, tv_show: tv_show}
    Given!(:episode_with_release){create :episode, tv_show: tv_show}
    Given{create :episode_release, episode: episode_with_release}

    When do
      get api_v1_tv_show_path(tv_show.id), env: @env
    end

    Given(:parsed_response){JSON.parse(response.body)}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response['name']).to eq tv_show.name}
    And{expect(parsed_response["released_episodes"].count).to eq 1}
    And{expect(parsed_response["released_episodes"].first['name']).to eq episode_with_release.name}
  end
end
