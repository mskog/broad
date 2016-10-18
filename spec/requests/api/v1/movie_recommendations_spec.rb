require 'spec_helper'

describe "API:V1:MovieRecommendations", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/json'
  end

  describe "Index" do
    Given!(:credential){create :credential, name: 'trakt'}

    When do
      get api_v1_movie_recommendations_path, env: @env
    end

    Given(:parsed_response){JSON.parse(response.body)}
    Given(:first_result){parsed_response.first}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response.count).to eq 10}
    And{expect(first_result['title']).to eq 'Strange Days'}
    And{expect(first_result['ids']['tmdb']).to eq 281}
  end
end
