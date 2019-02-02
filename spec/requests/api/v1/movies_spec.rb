require 'spec_helper'

describe "API:V1:Movies", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/json'
  end

  describe "Index" do
    When do
      get api_v1_movies_path, env: @env
    end

    context "with a text query" do
      Given!(:movie){create :movie, watched: true}
      Given(:parsed_response){JSON.parse(response.body)}
      Given(:first_result){parsed_response.first}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response.count).to eq 1}
      And{expect(first_result['title']).to eq 'The Matrix'}
    end
  end
end
