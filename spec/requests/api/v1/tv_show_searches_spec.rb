require 'spec_helper'

describe "API:V1:TvShowSearches", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/json'
  end

  describe "Index" do
    When do
      get api_v1_tv_show_searches_path, params: params, env: @env
    end

    context "with a text query" do
      Given(:query){'better call saul'}
      Given(:params){{query: query}}
      Given(:parsed_response){JSON.parse(response.body)}
      Given(:first_result){parsed_response.first}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response.count).to eq 3}
      And{expect(first_result['title']).to eq 'Better Call Saul'}
    end
  end
end
