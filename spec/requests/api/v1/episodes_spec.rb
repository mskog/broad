require 'spec_helper'

describe "API:V1:Episodes", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/json'
  end

  describe "Index" do
    When do
      get api_v1_episodes_path, env: @env
    end

    context "Listing episodes" do
      Given!(:episode){create :episode}
      Given{create :episode_release, episode: episode}
      Given(:parsed_response){JSON.parse(response.body)}
      Given(:first_result){parsed_response.first}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response.count).to eq 1}
      And{expect(first_result["name"]).to eq 'hannibal'}
    end
  end

  describe "Show" do
    When do
      get api_v1_episode_path(episode.id), env: @env
    end

    Given!(:episode){create :episode}
    Given{create :episode_release, episode: episode}
    Given(:parsed_response){JSON.parse(response.body)}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response["name"]).to eq 'hannibal'}
  end
end
